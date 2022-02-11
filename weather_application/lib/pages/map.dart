import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/models/page.dart';
import 'package:weather_application/pages/search.dart';

CameraPosition _kInitialPosition =
    const CameraPosition(target: LatLng(37.3826, -6.0066), zoom: 8.0);

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
  LatLng _lastTap = const LatLng(0, 0);

  @override
  void initState() {
    coordenadas();
    super.initState();
  }

  coordenadas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('lat') != null) {
      double? lat = prefs.getDouble('lat');
      double? lng = prefs.getDouble('lng');
      _lastTap = LatLng(lat!, lng!);
      _kInitialPosition= CameraPosition(target: LatLng(prefs.getDouble('lat')!,prefs.getDouble('lng')!), zoom: 8.0);
    } else {
      _kInitialPosition =
          const CameraPosition(target: LatLng(37.3826, -6.0066), zoom: 8.0);
      return _lastTap = const LatLng(37.3826, -6.0066);
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
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setDouble('lat', pos.latitude);
        prefs.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {});
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 40.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: googleMap,
          ),
        ),
      )
    ];
    return  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: columnChildren,
          ),Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    child: Container(
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text('Selecciona una ciudad en el mapa'),
                      ),
                    ),
                  ),
                ),
              ),
        ],
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
