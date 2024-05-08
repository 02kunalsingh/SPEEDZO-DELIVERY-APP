// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, use_build_context_synchronously, prefer_const_constructors, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomaNavigator/bottomnavigator.dart';
import 'map.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool isloading1 = false;
  bool isloading = false;
  String? location = "";
  var address = "";
  @override
  void initState() {
    super.initState();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    final locationcontroller = TextEditingController();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddress(Position position) async {
    List<Placemark> mplace =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = mplace[0];
    late var address = "${place.subLocality}\n${place.locality}";

    // Save the address to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', address);

    await updateUserLocationInFirestore(
        address, position.latitude, position.longitude);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigatorScreen(),
        settings: RouteSettings(
          arguments: address,
        ),
      ),
    );
  }

  Future<void> updateUserLocationInFirestore(
      String address, double latitude, double longitude) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .set({
          'location': address,
          'latitude': latitude,
          'longitude': longitude,
        }, SetOptions(merge: true));
        print('Location updated successfully!');
      } catch (e) {
        print('Error updating location: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromARGB(255, 51, 94, 187),
        title: Text("Set your location"),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
              },
              icon: const Icon(
                Icons.close_sharp,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              hintText: "search Your Location",
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
        const Divider(
          height: 5,
          thickness: 5,
        ),

        //set location on map

        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => GMap(),
                ),
                (route) => false);
          },
          icon: Image.asset(
            "assets/location/location.png",
            height: 20,
            color: Colors.red,
          ),
          label: isloading
              ? CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 1,
                )
              : Text(
                  "Pick location on map",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 51, 94, 187),
              elevation: 10,
              fixedSize: const Size(double.infinity, 40),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
        SizedBox(
          height: 10,
        ),

        //use current location
        ElevatedButton.icon(
          onPressed: () async {
            setState(() {
              isloading1 = true;
            });
            Position position = await determinePosition();
            getAddress(position);
            setState(() {
              isloading1 = false;
            });
          },
          icon: Image.asset(
            "assets/location/pin.png",
            height: 20,
            color: Colors.red,
          ),
          label: isloading1
              ? CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 1,
                )
              : Text("Use current location",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 51, 94, 187),
              elevation: 10,
              fixedSize: const Size(double.infinity, 40),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),

        SizedBox(
          height: 10,
        ),

        const Divider(
          height: 2,
          thickness: 2,
        ),
        const Padding(
          padding: EdgeInsets.only(right: 180, top: 10),
          child: Text(
            "Nearby Locations..",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
