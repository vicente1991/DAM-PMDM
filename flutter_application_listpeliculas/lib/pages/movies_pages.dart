import 'dart:convert';
import 'package:flutter_application_listpeliculas/models/movies_model.dart';
import 'package:flutter_application_listpeliculas/models/rated_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key, required this.title}) : super(key: key);

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          title: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.grey[200],
                          child: Image.asset('assets/perfil.png', width: 45),
                          shape: const CircleBorder(),
                        ),
                        const Text('Impostor',
                            style: TextStyle(color: Colors.black, fontSize: 16))
                      ]),
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.grey[200],
                        child: Icon(
                          Icons.cast,
                          size: 15.0,
                          color: Colors.deepPurple[400],
                        ),
                        padding: const EdgeInsets.all(7.0),
                        shape: const CircleBorder(),
                      )
                    ],
                  )))),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: const Text('Movie, Series, TV Shows',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          labelText: 'Search',
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.white),
                          )),
                    ))),
            RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Colors.deepPurple[400],
              child: const Icon(
                Icons.tune,
                size: 20.0,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(14.0),
              shape: const CircleBorder(),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text('Popular Movies',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))))
          ]),
          FutureBuilder<List<MoviesData>>(
            future: fetchMovies(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text('loading...');
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    return _moviesList(context, snapshot);
                  }
              }
            },
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text('Rated Movies',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          FutureBuilder<List<RatedData>>(
            future: fetchMovies2(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text('loading...');
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    return _moviesList2(context, snapshot);
                  }
              }
            },
          )
        ],
      )),
    );
  }

  Widget _getMoviesImg(MoviesData img) {
    return Image.network(
      'https://image.tmdb.org/t/p/w200${img.posterPath}',
      fit: BoxFit.cover,
    );
  }

  Future<List<MoviesData>> fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=412b34903210aefd34b0ef308f8b2ba0&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Widget _moviesList(
      BuildContext movieList, AsyncSnapshot<List<MoviesData>> snapshot) {
    List<MoviesData>? values = snapshot.data;
    return SizedBox(
      height: 545,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
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
              Navigator.pushNamed(context, '/movie_details', arguments: movies);
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

  Widget _getMoviesImg2(RatedData img) {
    return Image.network(
      'https://image.tmdb.org/t/p/w200${img.posterPath}',
      fit: BoxFit.cover,
    );
  }

  Future<List<RatedData>> fetchMovies2() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=412b34903210aefd34b0ef308f8b2ba0&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return RatedModel.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Widget _moviesList2(
      BuildContext movieList, AsyncSnapshot<List<RatedData>> snapshot) {
    List<RatedData>? values = snapshot.data;
    return SizedBox(
      height: 545,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: values?.length,
        itemBuilder: (context, index) {
          return _moviesItem2(values![index], index);
        },
      ),
    );
  }

  Widget _moviesItem2(RatedData movies, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, '/movie_details', arguments: movies);
            },
            child: SizedBox(
              width: 30,
              height: 500,
              child: Column(
                children: [
                  Text(movies.title),
                  _getMoviesImg2(movies),
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
