import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122334';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener((){
      onChange();
    });
  }
  void onChange(){
    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async{
    String kPLACES_API_KEY = "AIzaSyCA40gS_s-bVF9xC8BpXVl159qoQeTgHAg";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if(response.statusCode == 200){
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception("Failed to load data");
    }

  }

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
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search places with name',
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _placesList.length,
                    itemBuilder: (context,index){
                       return ListTile(
                         title: Text(_placesList[index]['description']),
                       );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
