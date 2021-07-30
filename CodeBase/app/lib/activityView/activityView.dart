// @dart=2.3

import 'dart:async';
import 'package:app/home/event.dart';
import 'package:app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityView extends StatefulWidget {
  Event events;
  int index;
  ActivityView({this.events, this.index});

  @override
  State<ActivityView> createState() => HomeState();
}

class HomeState extends State<ActivityView> {
  Completer<GoogleMapController> _controller = Completer();
  double width = 375;
  double height = 80;
  bool pressed = true;
  bool shouldBeKidFriendly = false;
  double heightSizedBox = 50;
  Position currentPosition;
  GoogleMapController newGoogleMapController;
  int indexOfPressedActivity;
  bool activityGotPressed = false;
  bool inListView = true;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void initState() {
    super.initState();
  }

  void _getBackToSearch(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  void locatePosition() async {
    Position position = await Geolocator.getLastKnownPosition();
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 15);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void _addAllMarkers() async {
    print("hey");

    List<Location> locations =
        await locationFromAddress(widget.events.address.toString());
    print(locations);
    final MarkerId markerId = MarkerId(widget.events.name);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(locations[0].latitude, locations[0].longitude),
      infoWindow: InfoWindow(
          title: markerId.value.toString(),
          snippet: widget.events.budget + "€"),
      onTap: () {
        print("tapped");
      },
      onDragEnd: (LatLng position) {
        print("draged");
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 60, left: 15),
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            newGoogleMapController = controller;
            locatePosition();
            _addAllMarkers();
          },
          markers: Set<Marker>.of(markers.values),
        ),
        Align(
            alignment: Alignment(0.1, 1),
            child: new AnimatedContainer(
                height: 400,
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
                  Row(
                    children: [
                      Spacer(flex: 2),
                      Container(
                          child: Visibility(
                              visible: inListView == true,
                              child: SizedBox(
                                  width: 70,
                                  height: heightSizedBox,
                                  child: BackButton()))),
                      Spacer(flex: 2),
                      Text(
                        "What's the plan for today?",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Spacer(flex: 2)
                    ],
                  ),
                  Container(
                      height: 320,
                      child: Column(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          Row(
                            children: [
                              Image.network(
                                widget.events.imageURL.toString(),
                                width: 250,
                              ),
                              Container(
                                width: 173,
                                child: Column(
                                  children: [
                                    Text(
                                      widget.events.name.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Divider(
                                      height: 20,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Text(widget.events.budget.toString() + "€",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Divider(
                                      height: 20,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Text(widget.events.address.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Divider(
                                      height: 20,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () => {_launchURL()},
                              child: Text("Visit Website",
                                  style: TextStyle(color: Colors.black))),
                          Spacer(
                            flex: 3,
                          ),
                        ],
                      ))
                ])))
      ],
    ));
  }

  _launchURL() async {
    var url = "http://" + widget.events.url.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void updateState() {
    setState(() {
      if (height == 400) {
        height = 120;
        pressed = false;
      } else {
        height = 400;
        pressed = true;
      }
    });
  }
}
