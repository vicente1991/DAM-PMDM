import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/models/page.dart';
import 'package:weather_application/pages/search.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(37.3826, -6.0066), zoom: 15.0);

class MapClickPage extends GoogleMapExampleAppPage {
  const MapClickPage() : super(const Icon(Icons.mouse), 'Map click');

  @override
  Widget build(BuildContext context) {
    return const _MapClickBody();
  }
}

class _MapClickBody extends StatefulWidget {
  const _MapClickBody();

  @override
  State<StatefulWidget> createState() => _MapClickBodyState();
}

class _MapClickBodyState extends State<_MapClickBody> {
  _MapClickBodyState();

  GoogleMapController? mapController;
  LatLng _lastTap = LatLng(37.3826, -6.0066);
  LatLng? _lastLongPress;

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      onTap: (LatLng pos) async {
        setState(() {
          _lastTap = pos;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setDouble('lat', pos.latitude);
        prefs.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 90.0, bottom: 88.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: googleMap,
          ),
        ),
      ),
      SearchBarWidget()
    ];
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnChildren,
        ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  Marker _createMarker() {
    return Marker(markerId: const MarkerId("marker"), position: _lastTap);
  }
}
