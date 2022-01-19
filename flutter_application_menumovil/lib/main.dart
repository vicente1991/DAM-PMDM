import 'package:flutter/material.dart';
import 'package:flutter_application_menumovil/models/people_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_menumovil/models/planets_response.dart';



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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Star wars Universe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 late Future<List<Planets>> items;
  late Future<List<People>> people;

  @override
  void initState() {
    items = fetchPlanets();
    people = fetchPeoples();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.auto_awesome), text: "Planetas",),
                Tab(icon: Icon(Icons.account_box),text: "Personajes",),
              ],
            ),
            title: const Text('Menu'),
          ),
          body: TabBarView(
            children: [
              SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Planets>>(
                      future: items,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _planetList(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        {
                          return const Text("buffering");
                        }
                      }),
                ),
              SizedBox(
                  height: 200,
                  child: FutureBuilder<List<People>>(
                      future: people,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _peopleList(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        {
                          return const Text("buffering");
                        }
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Future<List<Planets>> fetchPlanets() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Widget _planetList(List<Planets> planetList) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: planetList.length,
      itemBuilder: (context, index) {
        return _planetItem(planetList.elementAt(index));
      },
    );
  }

  Widget _planetItem(Planets planets) {
    List<String> owo = planets.url.split("/");
    String id = owo[5];
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        color: const Color.fromRGBO(1, 1, 1, 0),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: SizedBox(
            width: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    planets.name,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                ),
                Image.network(
                  "https://starwars-visualguide.com/assets/img/planets/${id}.jpg",
                  width: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<List<People>> fetchPeoples() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _peopleList(List<People> peopleList) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: peopleList.length,
      itemBuilder: (context, index) {
        return _peopleItem(peopleList.elementAt(index));
      },
    );
  }

  Widget _peopleItem(People people) {
    List<String> owo = people.url.split("/");
    String id = owo[5];
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        color: const Color.fromRGBO(1, 1, 1, 0),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: SizedBox(
            width: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    people.name,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                ),
                Image.network(
                  "https://starwars-visualguide.com/assets/img/characters/${id}.jpg",
                  width: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}