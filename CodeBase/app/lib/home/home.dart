import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 60, left: 15),
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Align(
            alignment: Alignment(0.1, 1),
            child: new Container(
              height: 80.0,
              color: Colors.transparent,
              child: new Container(
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 219, 219, 219),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(35.0),
                      topRight: const Radius.circular(35.0),
                    ),
                    border: Border.all(
                      color: Colors.black26,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: new Center(
                      child: SizedBox(
                          width: 375,
                          height: 50,
                          child: new ElevatedButton(
                            onPressed: () => animateSearchbar(),
                            child: Text('Whats the plan for today?'),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 189, 189, 185)),
                          )))),
            ))
      ],
    ));
  }

  void animateSearchbar() {
    print('Animate'); // Print to console.
  }

  _getLocation() async {
    var location = new Location();
    try {
      var currentLocation = await location.getLocation();

      print("locationLatitude: ${currentLocation.latitude}");
      print("locationLongitude: ${currentLocation.longitude}");
      setState(
          () {}); //rebuild the widget after getting the current location of the user
    } on Exception {
      var currentLocation = null;
    }
  }
}
