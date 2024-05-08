import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:k/screens/location/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOnline = false;
  String address = "";
   bool isloading = false;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
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
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(225, 1, 35, 255),
        title: Row(
          children: [
            Text(
              _isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 15,
                color: _isOnline ? Colors.green : Colors.red,
              ),
            ),
            Switch(
              value: _isOnline,
              activeColor: Colors.green,
              inactiveTrackColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
               Position position = await determinePosition();
            getAddress(position);
            setState(() {
              isloading = false;
            });
            },
            icon: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 28,
            ),
            label: Row(
              children: [
                Text(
                  "Set Location" ?? address,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
      body: const GMap(),
    );
  }
}
