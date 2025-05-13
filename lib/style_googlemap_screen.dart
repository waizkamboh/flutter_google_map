import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGooglemapScreen extends StatefulWidget {
  const StyleGooglemapScreen({super.key});

  @override
  State<StyleGooglemapScreen> createState() => _StyleGooglemapScreenState();
}

class _StyleGooglemapScreenState extends State<StyleGooglemapScreen> {

  String mapTheme = "";
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.852222258431745, 73.4497066242562),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/maptheme/silver_theme.json").then((value){
      mapTheme = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Theme"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/silver_theme.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                    child: Text("Silver"),
                ),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/night_theme.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text("Dark"),
                ),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/dark_theme.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text("Night"),
                ),
              ]
          )
        ],
      ),
      body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller){
              controller.setMapStyle(mapTheme);
              _controller.complete(controller);
            },
          )
      ),

    );
  }
}
