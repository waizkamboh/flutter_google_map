import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatlongToAddress extends StatefulWidget {
  const ConvertLatlongToAddress({super.key});

  @override
  State<ConvertLatlongToAddress> createState() => _ConvertLatlongToAddressState();
}

class _ConvertLatlongToAddressState extends State<ConvertLatlongToAddress> {

  String latLong = "", address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(latLong),
          GestureDetector(
            onTap: () async {
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

               setState(() {
                 latLong = "${locations.last.latitude} ${locations.last.longitude}";
               });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: Center(child: Text("Convert")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
