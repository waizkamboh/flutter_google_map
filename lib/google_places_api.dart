import 'package:flutter/material.dart';

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Places Api"),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
