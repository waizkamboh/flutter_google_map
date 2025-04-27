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
          Text(address),
          GestureDetector(
            onTap: () async {
              List<Location> locations = await locationFromAddress("QCRV+X46, QCRV+X46, Chak 5/4 L, Okara, Okara, Punjab, , Pakistan");
              List<Placemark> placemarks = await placemarkFromCoordinates(30.792640430216533, 73.44316504787581);
               final Placemark place = placemarks.first;
               setState(() {
                 latLong = "${locations.last.latitude} ${locations.last.longitude}";
                 address = "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
                 print(address);
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
