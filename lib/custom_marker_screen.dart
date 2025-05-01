import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  List<String> images = ["assets/images/guard.png", "assets/images/location.png", "assets/images/man.png","assets/images/motorbike.png","assets/images/car.png"];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlang = <LatLng>[LatLng(30.8116649608183, 73.44355347361368), LatLng(30.852222258431745, 73.4497066242562),LatLng(30.813890471934677, 73.44562176327965),LatLng(30.792640430216533, 73.44316504787581),LatLng(30.795981183553607, 73.45883300140586)];

  static const CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(30.792640430216533, 73.44316504787581),
      zoom: 14
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){

    for(int i = 0; i<images.length; i++){
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlang[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: "This is title marker:$i",
          )
        )
      );
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
           child: GoogleMap(
               initialCameraPosition: _cameraPosition,
             mapType: MapType.normal,
             myLocationEnabled: true,
             myLocationButtonEnabled: true,
             markers: Set<Marker>.of(_marker),
             onMapCreated: (GoogleMapController controller){
                 _controller.complete(controller);
             },
           )),
    );
  }
}
