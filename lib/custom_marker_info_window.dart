import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _makers = <Marker>[];
  final List<LatLng> _latlang = <LatLng>[LatLng(30.8116649608183, 73.44355347361368), LatLng(30.852222258431745, 73.4497066242562),LatLng(30.813890471934677, 73.44562176327965),LatLng(30.792640430216533, 73.44316504787581),LatLng(30.795981183553607, 73.45883300140586)];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  loadData(){

    for(int i = 0 ; i < _latlang.length ; i++){
      if(i == 1 ){
        _makers.add(Marker(

            markerId: MarkerId(i.toString()),
            position: _latlang[i],
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "I am here",
                                style:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Triangle.isosceles(
                    //   edge: Edge.BOTTOM,
                    //   child: Container(
                    //     color: Colors.blue,
                    //     width: 20.0,
                    //     height: 10.0,
                    //   ),
                    // ),
                  ],
                ),
                _latlang[i],
              );
            }
        ));
      }else {
        _makers.add( Marker(
            markerId: MarkerId(i.toString()),
            position: _latlang[i],
          icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(
                          image:  DecorationImage(
                              image: NetworkImage('https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg'),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high),
                          borderRadius:  BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.red,
                        ),
                      ),
                      const   Padding(
                        padding:  EdgeInsets.only(top: 10 , left: 10 , right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Beef Tacos',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '.3 mi.',
                              style: TextStyle(color: Colors.black),

                            )
                          ],
                        ),
                      ),
                      const  Padding(
                        padding:  EdgeInsets.only(top: 10 , left: 10 , right: 10),
                        child: Text(
                          'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                          maxLines: 2,
                          style: TextStyle(color: Colors.black),

                        ),
                      ),

                    ],
                  ),
                ),
                _latlang[i],
              );
            }
        ));
      }

      setState(() {

      });
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Marker Info Window'),
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(30.792640430216533, 73.44316504787581),
                  zoom: 14
              ),
              markers: Set<Marker>.of(_makers),
            onTap: (position){
             _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
                _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
                _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          )

        ],
      ),
    );
  }
}
