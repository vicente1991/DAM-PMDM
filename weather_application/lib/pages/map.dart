import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/models/page.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(37.3826,-6.0066), zoom: 15.0);


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
  LatLng? _lastTap;
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
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: googleMap,
          ),
        ),
      ),
    ];

    if (mapController != null) {
      final String lastTap = 'Tap:\n${_lastTap ?? ""}\n';
      final String lastLongPress = 'Long press:\n${_lastLongPress ?? ""}';
      columnChildren.add(Center(
          child: Text(
        lastTap,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      )));
      columnChildren.add(Center(
          child: Text(
        _lastTap != null ? 'Ubicación' : '',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white)
      )));
      columnChildren.add(Center(
          child: Text(
        lastLongPress,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white)
      )));
      columnChildren.add(Center(
          child: Text(
        _lastLongPress != null ? 'Long pressed' : '',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white)
      )));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    
    setState(() {
      mapController = controller;
    });
    
  }
}