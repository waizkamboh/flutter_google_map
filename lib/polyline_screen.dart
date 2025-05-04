import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _completer = Completer();

  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.78931943260586, 73.44910332852145),
    zoom: 14,
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyLine = {};

  List<LatLng> latLong = [
    LatLng(30.8116649608183, 73.44355347361368),
    LatLng(30.852222258431745, 73.4497066242562),
    LatLng(30.813890471934677, 73.44562176327965),
    LatLng(30.792640430216533, 73.44316504787581),
    LatLng(30.795981183553607, 73.45883300140586)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i<latLong.length; i++){
      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
          position: latLong[i],
          icon: BitmapDescriptor.defaultMarker,

        ),

      );
      setState(() {
        
      });
      _polyLine.add(
        Polyline(
          polylineId: PolylineId('1'),
          points: latLong,
          color: Colors.orange,

        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PolyLine"),),
      body: GoogleMap(
          initialCameraPosition: _cameraPosition,
          mapType: MapType.normal,
        myLocationButtonEnabled: true,
        markers: _marker,
        polylines: _polyLine,
        onMapCreated: (GoogleMapController controller){
            _completer.complete(controller);
        },
      ),
    );
  }
}