import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_pruebaflutter/models/people-popular.dart';

import 'package:http/http.dart' as http;

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  late Future<List<PersonData>> futureResults;

  @override
  void initState() {
    super.initState();
    futureResults = fetchPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, left: 50, right: 50),
                child: Text(
                  'Mejores Actores',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Poppins'),
                ),
              ),
              const Text(
                'Actores',
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
              FutureBuilder<List<PersonData>?>(
                  future: futureResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _peopleList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<List<PersonData>> fetchPopularPeople() async {
    final result = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/popular?api_key=412b34903210aefd34b0ef308f8b2ba0&language=en-US&page=1'));

    if (result.statusCode == 200) {
      return PersonResponse.fromJson(jsonDecode(result.body)).results!;
    } else {
      throw Exception("No se ha podido encontrar esta lista");
    }
  }

  Widget _peopleList(List<PersonData> peopleList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 400,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: peopleList.length,
            itemBuilder: (context, index) {
              return _personItem(peopleList.elementAt(index));
            }),
      ),
    );
  }

  Widget _personItem(PersonData person) {
    return Card(
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: person);
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        person.profilePath.toString()),
                                fit: BoxFit.fill)),
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    Text(person.name!),
                  ],
                ))));
  }
}
