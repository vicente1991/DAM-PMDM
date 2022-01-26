import 'dart:convert';
import 'package:flutter_application_listpeliculas/models/movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    ),
    home: const Movies(title: 'Flutter Demo Home Page'),
  );
}

class Movies extends StatefulWidget {
  const Movies({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Movies> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<Movies> {
  late Future<List<MoviesData>> items;
  

  @override
  void initState() {
    items = fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<List<Movies>>(
            future: fetchMovies(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              return _moviesList(context, snapshot);
            }
        }
             /* return const Center(child: CircularProgressIndicator());*/
            },
          )
        ],
      ),
    );
  }

 

  Widget _getMoviesImg(MoviesData img) {
    
      return Image.network('', fit: BoxFit.cover,);
  }

  Future<List<MoviesData>> fetchMovies() async {
    final response = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(jsonDecode(response.body)).movies;
    } else {
      throw Exception('Failed to load anime');
    }
  }

  Widget _moviesList(BuildContext movieList, AsyncSnapshot<List<MoviesData>> snapshot) {
    List<MoviesData>? values = snapshot.data;
    return SizedBox(
      height: 545,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: values?.length,
        itemBuilder: (context, index) {
          return _moviesItem(values![index], index);
        },
      ),
    );
  }

  Widget _moviesItem(MoviesData movies, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 30,
              height: 500,
              child: Column(
                children: [
                  Text(movies.title),
                  _getMoviesImg(movies),
                  Text(movies.title)
                ],
              ),
            ),
          ),
        ));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}