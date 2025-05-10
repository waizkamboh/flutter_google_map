import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGooglemapScreen extends StatefulWidget {
  const StyleGooglemapScreen({super.key});

  @override
  State<StyleGooglemapScreen> createState() => _StyleGooglemapScreenState();
}

class _StyleGooglemapScreenState extends State<StyleGooglemapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.852222258431745, 73.4497066242562),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          )
      ),

    );
  }
}
