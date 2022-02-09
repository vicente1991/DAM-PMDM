import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/models/page.dart';
import 'package:weather_application/pages/search.dart';
import 'package:weather_application/utils/preferences.dart';

CameraPosition _kInitialPosition =
    const CameraPosition(target: LatLng(37.3826, -6.0066), zoom: .0);

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
  GoogleMapController? mapController;
  LatLng _lastTap = LatLng(0, 0);
  LatLng? _lastLongPress;

  @override
  void initState() {
    super.initState();
    coordenadas();
  }

  coordenadas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('lat') != null) {
      double? lat = prefs.getDouble('lat');
      double? lng = prefs.getDouble('lng');
      _lastTap = LatLng(lat!, lng!);
      _kInitialPosition = CameraPosition(target: _lastTap, zoom: 5.0);
    } else {
      _kInitialPosition = const CameraPosition(
          target: LatLng(37.3754865, -6.0250989), zoom: 5.0);
      return _lastTap = const LatLng(37.3754865, -6.0250989);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      onTap: (LatLng pos) async {
        setState(() {
          _lastTap = pos;
          coordenadas();
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
        padding: const EdgeInsets.only(top: 239.0, bottom: 40.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
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
        children: [
          Column(
            children: columnChildren,
          )
        ],
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
