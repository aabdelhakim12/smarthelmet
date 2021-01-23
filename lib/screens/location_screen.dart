import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/loc';

  LocationScreen({Key key}) : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();

  GoogleMapController mapController;
  final referenceDatabase = FirebaseDatabase.instance;
  BitmapDescriptor custom;
  double lat;
  double long;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 20.0,
          ),
        ),
      );
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
  }

  final referenceDatabas = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
                markers.add(Marker(
                  markerId: MarkerId('0'),
                  position: LatLng(lat, long),
                  infoWindow: InfoWindow(title: 'Worker location'),
                  icon: custom,
                ));
                _circles.add(
                  Circle(
                      circleId: CircleId("0"),
                      center: LatLng(lat, long),
                      radius: 10,
                      strokeWidth: 2,
                      fillColor: Color.fromRGBO(102, 51, 153, .5)),
                );
                return Container();
              }),
          GoogleMap(
            mapType: MapType.satellite,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
            ),
            circles: _circles,
            onMapCreated: onMapCreated,
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
          ),
          Positioned(
            left: 5,
            bottom: 0,
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'view worker location',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(lat, long),
                        zoom: 20.0,
                      ),
                    ),
                  );
                });
              },
            ),
          )
        ],
      ),
    );
  }
}