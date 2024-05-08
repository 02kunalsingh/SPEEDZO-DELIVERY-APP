// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng initialPosition = LatLng(19.1176, 72.9060);

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  final Completer<GoogleMapController> _googleMapController = Completer();

  // ignore: unused_field
  LatLng _currentPosition = initialPosition;
  String _address = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                const CameraPosition(target: initialPosition, zoom: 14),
            onMapCreated: (GoogleMapController controller) {
              _googleMapController.complete(controller);
            },
            onCameraMove: (CameraPosition position) {},
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _address,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color.fromARGB(255, 51, 94, 187),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   icon: const Icon(
                  //     Icons.my_location_rounded,
                  //     color: Colors.white,
                  //   ),
                  //   label: _isLoading
                  //       ? const CircularProgressIndicator(
                  //           color: Colors.white,
                  //           strokeWidth: 1,
                  //         )
                  //       : const Text(
                  //           "Use Location",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
