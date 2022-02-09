import 'package:flutter/material.dart';
import 'package:weather_application/pages/home_page.dart';
import 'package:weather_application/pages/place_select.dart';
import 'pages/mars_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/place_selected': (context) => const PlaceSelected(title: '',),
      '/mars': (context) => const Mars(),
      
    },);
  }
}