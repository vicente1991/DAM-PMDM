import 'package:flutter/material.dart';
import 'package:flutter_application_listpeliculas/models/rated_model.dart';

class RatedDetailsPage extends StatefulWidget {
  const RatedDetailsPage({Key? key}) : super(key: key);

  @override
  _RatedDetailsPageState createState() => _RatedDetailsPageState();
}

class _RatedDetailsPageState extends State<RatedDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as RatedData;

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                      'https://image.tmdb.org/t/p/w500/' + movie.posterPath,
                      width: MediaQuery.of(context).size.width * 0.4)),
              Text(movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(movie.voteAverage.toString(),
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[400])),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Release date',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[400])),
                            Text(movie.releaseDate.toString(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Language',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[400])),
                            Text(movie.originalLanguage,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Votos',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[400])),
                            Text(movie.voteCount.toString(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ]),
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Argumento',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(movie.overview,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400))))
            ])));
  }
}
