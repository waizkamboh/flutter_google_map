import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController>  _controller = Completer();
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
    ), Marker(
        markerId: MarkerId('3'),
        position: LatLng(30.852222258431745, 73.4497066242562),
      infoWindow: InfoWindow(
        title: "My Sister Home"
      )
    ) ,Marker(
        markerId: MarkerId('4'),
        position: LatLng(30.8116649608183, 73.44355347361368),
      infoWindow: InfoWindow(
        title: "My City"
      )
    ),
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
        body: SafeArea(
          child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              myLocationEnabled: true,
              mapType: MapType.normal,
              compassEnabled: false,
              markers: Set<Marker>.of(_marker),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(30.852222258431745, 73.4497066242562),
                zoom: 14,
              )
            ));
            setState(() {

            });
          }
      ),
    );
  }
}
