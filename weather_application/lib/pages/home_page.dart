import 'package:flutter/material.dart';
import 'package:weather_application/pages/city_select_page.dart';
import 'package:weather_application/pages/mars_page.dart';
import 'package:weather_application/pages/place_select.dart';

import 'map.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PlaceSelected(
       title: 'Place',
    ),

    MapClickPage(),


    Mars()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/earth.jpg",
                ),
                fit: BoxFit.cover)),
        
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined,),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_tilt_shift_sharp),
            label: 'Mars',
          ),
        ],
       currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
    );
  }
}