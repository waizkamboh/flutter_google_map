import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.852222258431745, 73.4497066242562),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latlang = <LatLng>[LatLng(30.8116649608183, 73.44355347361368), LatLng(30.852222258431745, 73.4497066242562),LatLng(30.813890471934677, 73.44562176327965),LatLng(30.792640430216533, 73.44316504787581),LatLng(30.795981183553607, 73.45883300140586)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
         child: GoogleMap(
             initialCameraPosition: _cameraPosition,
           mapType: MapType.normal,
           myLocationButtonEnabled: true,
           myLocationEnabled: true,
           markers: Set<Marker>.of(_markers),
           onMapCreated: (GoogleMapController controller){
               _controller.complete(controller);
           },
         )
     ),
    );
  }
}
