import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class Location extends StatefulWidget {
  Location({Key key}) : super(key: key);
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final referenceDatabase = FirebaseDatabase.instance;
  var markers = HashSet<Marker>();
  var circles = HashSet<Circle>();

  BitmapDescriptor custom;
  double lat;
  double long;
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;
  Position _currentPosition;

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
        markers.add(
          Marker(
            markerId: MarkerId("0"),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
              title: "worker location",
            ),
            icon: custom,
          ),
        );
        circles.add(
          Circle(
              visible: true,
              circleId: CircleId("1"),
              center: LatLng(lat, long),
              radius: 10,
              strokeWidth: 2,
              fillColor: Color.fromRGBO(102, 51, 153, .5)),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  getCustomMarker() async {
    custom = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/marker.png');
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Scaffold(
        body: Stack(
      children: [
        FirebaseAnimatedList(
            shrinkWrap: true,
            query: ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              double _latitude = snapshot.value['latitude']['val'];
              double _longitude = snapshot.value['longitude']['val'];
              lat = _latitude;
              long = _longitude;
              return Container();
            }),
        GoogleMap(
          initialCameraPosition: _initialLocation,
          markers: markers,
          circles: circles,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.satellite,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
        Positioned(
          bottom: 0,
          left: 5,
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'view worker location',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(lat, long),
                    zoom: 20.0,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
