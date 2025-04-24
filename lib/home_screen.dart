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
      target: LatLng(30.792640430216533, 73.44316504787581),
    zoom: 14,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(30.792640430216533, 73.44316504787581),
        infoWindow: InfoWindow(
          title: "My Current Position",
        )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(30.813890471934677, 73.44562176327965),
      infoWindow: InfoWindow(
        title: "My College Position"
      )
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: GoogleMap(
            initialCameraPosition: _cameraPosition,
            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: false,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
              _completer.complete(controller);
            },
        ),
    );
  }
}
