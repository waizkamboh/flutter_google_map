import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(30.78931943260586, 73.44910332852145),
    zoom: 14,
  );
  final Set<Polygon> _polyGone = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(30.78931943260586, 73.44910332852145),
    LatLng(30.78931943260586, 73.44910332852145),

  ] ;


  void _setPolyGone(){
    _polyGone.add(
        Polygon(polygonId: PolygonId('1') ,
            points: points ,
            strokeColor: Colors.deepOrange,
            strokeWidth: 5 ,
            fillColor: Colors.deepOrange.withOpacity(0.1),
            geodesic: true
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolyGone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PolyGone'),),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        polygons: _polyGone,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
