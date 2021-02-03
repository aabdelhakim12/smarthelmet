import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  final double lat, long;
  GoogleMapPage({this.lat, this.long});
  @override
  GoogleMapPageState createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  Set<Marker> markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();
  BitmapDescriptor custom;
  GoogleMapController mapController;

  getCustomMarker() async {
    custom = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/marker.png');
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.lat, widget.long),
            zoom: 20.0,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    markers.add(Marker(
      markerId: MarkerId('0'),
      position: LatLng(widget.lat, widget.long),
      infoWindow: InfoWindow(title: 'Worker location'),
      icon: custom,
    ));
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(widget.lat, widget.long),
          radius: 10,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(0, 51, 51, .6)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Flutter'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 12,
              ),
              circles: _circles,
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: onMapCreated),
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
                        target: LatLng(widget.lat, widget.long),
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
