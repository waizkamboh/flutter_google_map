import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController>  _completer = Completer();
  static final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: GoogleMap(
            initialCameraPosition: _cameraPosition,
            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: false,
            onMapCreated: (GoogleMapController controller){
              _completer.complete(controller);
            },
        ),
    );
  }
}
