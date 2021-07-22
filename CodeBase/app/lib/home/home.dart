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
  double width = 375;
  double height = 80;

  double heightSizedBox = 50;

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
            child: new AnimatedContainer(
                height: height,
                width: 500,
                duration: Duration(milliseconds: 85),
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
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
                      color: Colors.white,
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: new Container(
                  margin: EdgeInsets.only(
                      top: 20, left: 15, right: 15, bottom: height - 80),
                  child: SizedBox(
                      width: 375,
                      height: heightSizedBox,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                          size: 24.0,
                        ),
                        label: Text(
                          "What's the plan for today?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        onPressed: () {
                          updateState();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade200),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.black12)))),
                      )),
                )))
      ],
    ));
  }

  void updateState() {
    setState(() {
      if (height == 500) {
        height = 120;
      } else {
        height = 500;
      }
    });
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
