import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  loadData ()async{

    for(int i = 0 ; i< _latlang.length ; i++ ){

      Uint8List? image = await  _loadNetworkImage('https://images.bitmoji.com/3d/avatar/201714142-99447061956_1-s5-v1.webp') ;

      final ui.Codec markerImageCodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );

      final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
      _markers.add(
          Marker(markerId: MarkerId(i.toString()) ,
            position: _latlang[i],
            icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
            //icon: BitmapDescriptor.fromBytes(image!.buffer.asUint8List()),
            infoWindow: InfoWindow(
                title: 'This is title marker: '+i.toString()
            ),
          ));
      setState(() {

      });
    }
  }
  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration(size: Size.fromHeight(10) )).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png ,);
    return byteData?.buffer.asUint8List();
  }
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
