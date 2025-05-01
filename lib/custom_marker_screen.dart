import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;
  List<String> images = ["assets/images/guard.png", "assets/images/location.png", "assets/images/man.png","assets/images/motorbike.png","assets/images/car.png"];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlang = <LatLng>[LatLng(30.8116649608183, 73.44355347361368), LatLng(30.852222258431745, 73.4497066242562),LatLng(30.813890471934677, 73.44562176327965),LatLng(30.792640430216533, 73.44316504787581),LatLng(30.795981183553607, 73.45883300140586)];

  static const CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(30.792640430216533, 73.44316504787581),
      zoom: 14
  );

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{

    for(int i = 0 ; i < images.length ; i++){

      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 100);
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latlang[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
              title: 'The title of the marker'
          )
      ));
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
