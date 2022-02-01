import 'package:flutter/material.dart';
import 'package:flutter_application_listpeliculas/pages/home_page.dart';
import 'package:flutter_application_listpeliculas/pages/movie_details.dart';
import 'package:flutter_application_listpeliculas/pages/movies_pages.dart';
import 'package:flutter_application_listpeliculas/pages/rated_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/movies': (context) => const Movies(title: 'Movies'),
        '/movie_details': (context) => const MovieDetailsPage(),
        '/rated_details': (context) => const RatedDetailsPage(),
      },
    );
  }
}
