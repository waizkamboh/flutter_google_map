import 'package:flutter/material.dart';
import 'package:flutter_google_map/convert_latlong_to_address.dart';
import 'package:flutter_google_map/custom_marker_screen.dart';
import 'package:flutter_google_map/google_places_api.dart';
import 'package:flutter_google_map/home_screen.dart';
import 'package:flutter_google_map/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CustomMarkerScreen(),
    );
  }
}


