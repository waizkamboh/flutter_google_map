import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.852222258431745, 73.4497066242562),
    zoom: 14,
  );
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(30.852222258431745, 73.4497066242562),
        infoWindow: InfoWindow(
          title: "The title of the marker"
        )

    )
  ];

  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value){
      
    }).onError((error, stackTrace){
      debugPrint("Error${error.toString()}");
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _cameraPosition,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },

      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            getUserCurrentLocation().then((value) async{
              debugPrint("My current position");
              debugPrint("${value.latitude.toString()} ${value.longitude.toString()}");
              _markers.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: "My Current Position",
                  )
                )
              );
              CameraPosition cameraPosition = CameraPosition(
                  zoom: 14,
                  target: LatLng(value.latitude, value.longitude)
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {

              });
            });
          },
          child: Icon(Icons.local_activity),
      ),
    );
  }
}
