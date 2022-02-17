import 'package:flutter/material.dart';
import 'package:flutter_application_pruebaflutter/models/people-popular.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as PersonData;

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                      'https://image.tmdb.org/t/p/w500/' + person.profilePath!,
                      width: MediaQuery.of(context).size.width * 0.4)),
              Text(person.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Language',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[400])),
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
                      child: Text(person.popularity.toString(),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400))))
            ])));
  }
}
