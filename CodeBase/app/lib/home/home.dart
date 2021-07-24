import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  double width = 375;
  double height = 80;
  int _numberOfPeople = 0;
  int _index = 0;
  int _areKidsWithYouIndex = 0;
  int _kidsPauseIndex = 0;
  bool pressed = false;
  bool shouldBeKidFriendly = false;
  double heightSizedBox = 50;
  double _currentSliderValue = 20;

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    child: Column(children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: SizedBox(
                            width: 375,
                            height: heightSizedBox,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.search,
                                color: Colors.red,
                                size: 24.0,
                              ),
                              label: Container(
                                padding: EdgeInsets.only(
                                  bottom: 5, // Space between underline and text
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2.0, // Underline thickness
                                ))),
                                child: Text(
                                  "What's the plan for today?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              onPressed: () {
                                updateState();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                              color: Colors.black12)))),
                            )),
                      ),
                      pressed
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(),
                      pressed
                          ? Text(
                              "For how many people?",
                              style: TextStyle(fontSize: 18),
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(),
                      pressed
                          ? ToggleSwitch(
                              minWidth: 90.0,
                              minHeight: 70.0,
                              initialLabelIndex: _numberOfPeople,
                              cornerRadius: 20.0,
                              radiusStyle: true,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[300],
                              inactiveFgColor: Colors.white,
                              totalSwitches: 3,
                              iconSize: 30.0,
                              borderWidth: 1.0,
                              borderColor: [Colors.grey],
                              activeBgColors: [
                                [Colors.red],
                                [Colors.red],
                                [Colors.red],
                              ],
                              customIcons: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                                Icon(
                                  Icons.group,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                              ],
                              onToggle: (index) {
                                _numberOfPeople = index;
                              },
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(),
                      pressed
                          ? Text(
                              "What's your budget?",
                              style: TextStyle(fontSize: 18),
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 5,
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 0,
                            )
                          : SizedBox(),
                      pressed
                          ? Slider(
                              value: _currentSliderValue,
                              min: 0,
                              max: 150,
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValue = value;
                                  print(_currentSliderValue.round());
                                });
                              },
                            )
                          : SizedBox(),
                      pressed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  _currentSliderValue.round().toString(),
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text("€")
                              ],
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(),
                      pressed
                          ? Text(
                              "Should it be dog friendly?",
                              style: TextStyle(fontSize: 18),
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(),
                      pressed
                          ? ToggleSwitch(
                              minWidth: 90.0,
                              minHeight: 70.0,
                              initialLabelIndex: _areKidsWithYouIndex,
                              cornerRadius: 20.0,
                              radiusStyle: true,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[300],
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              iconSize: 30.0,
                              borderWidth: 1.0,
                              borderColor: [Colors.grey],
                              activeBgColors: [
                                [Colors.red],
                                [Colors.green],
                              ],
                              customIcons: [
                                Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                                Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                              ],
                              onToggle: (index) {
                                _areKidsWithYouIndex = index;
                              },
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(),
                      pressed
                          ? Text(
                              "Are kids with you?",
                              style: TextStyle(fontSize: 18),
                            )
                          : SizedBox(),
                      pressed
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(),
                      pressed
                          ? ToggleSwitch(
                              minWidth: 90.0,
                              minHeight: 70.0,
                              initialLabelIndex: _index,
                              cornerRadius: 20.0,
                              radiusStyle: true,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[300],
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              iconSize: 30.0,
                              borderWidth: 1.0,
                              borderColor: [Colors.grey],
                              activeBgColors: [
                                [Colors.red],
                                [Colors.green],
                              ],
                              customIcons: [
                                Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                                Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 55.0,
                                ),
                              ],
                              onToggle: (index) {
                                setState(() {
                                  if (index == 0) {
                                    _index = 0;
                                    shouldBeKidFriendly = false;
                                    height = 700;
                                  } else {
                                    _index = 1;
                                    shouldBeKidFriendly = true;
                                    height = 850;
                                  }
                                });
                              },
                            )
                          : SizedBox(),
                      pressed
                          ? shouldBeKidFriendly
                              ? SizedBox(
                                  height: 25,
                                )
                              : SizedBox()
                          : SizedBox(),
                      pressed
                          ? shouldBeKidFriendly
                              ? Text(
                                  "Do you need a kids pause?",
                                  style: TextStyle(fontSize: 18),
                                )
                              : SizedBox()
                          : SizedBox(),
                      pressed
                          ? shouldBeKidFriendly
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox()
                          : SizedBox(),
                      pressed
                          ? shouldBeKidFriendly
                              ? ToggleSwitch(
                                  minWidth: 90.0,
                                  minHeight: 70.0,
                                  initialLabelIndex: _kidsPauseIndex,
                                  cornerRadius: 20.0,
                                  radiusStyle: true,
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.grey[300],
                                  inactiveFgColor: Colors.white,
                                  totalSwitches: 2,
                                  iconSize: 30.0,
                                  borderWidth: 1.0,
                                  borderColor: [Colors.grey],
                                  activeBgColors: [
                                    [Colors.red],
                                    [Colors.green],
                                  ],
                                  customIcons: [
                                    Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 55.0,
                                    ),
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                      size: 55.0,
                                    ),
                                  ],
                                  onToggle: (index) {
                                    _kidsPauseIndex = index;
                                  },
                                )
                              : SizedBox()
                          : SizedBox(),
                    ])))
          ],
        ));
  }

  void updateState() {
    setState(() {
      if (height == 700) {
        height = 120;
        pressed = false;
      } else {
        height = 700;
        pressed = true;
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
