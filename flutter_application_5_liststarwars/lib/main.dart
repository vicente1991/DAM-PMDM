import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_5_liststarwars/models/people_response.dart';
import 'package:flutter_application_5_liststarwars/models/planets_response.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Planets> items = PlanetResponse.fromJson(jsonDecode(
          '{ "count": 60, "next": "https://swapi.dev/api/planets/?page=2", "previous": null, "results": [ { "name": "Tatooine", "rotation_period": "23", "orbital_period": "304", "diameter": "10465", "climate": "arid", "gravity": "1 standard", "terrain": "desert", "surface_water": "1", "population": "200000", "residents": [ "https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/2/", "https://swapi.dev/api/people/4/", "https://swapi.dev/api/people/6/", "https://swapi.dev/api/people/7/", "https://swapi.dev/api/people/8/", "https://swapi.dev/api/people/9/", "https://swapi.dev/api/people/11/", "https://swapi.dev/api/people/43/", "https://swapi.dev/api/people/62/" ], "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "created": "2014-12-09T13:50:49.641000Z", "edited": "2014-12-20T20:58:18.411000Z", "url": "https://swapi.dev/api/planets/1/" }, { "name": "Alderaan", "rotation_period": "24", "orbital_period": "364", "diameter": "12500", "climate": "temperate", "gravity": "1 standard", "terrain": "grasslands, mountains", "surface_water": "40", "population": "2000000000", "residents": [ "https://swapi.dev/api/people/5/", "https://swapi.dev/api/people/68/", "https://swapi.dev/api/people/81/" ], "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/6/" ], "created": "2014-12-10T11:35:48.479000Z", "edited": "2014-12-20T20:58:18.420000Z", "url": "https://swapi.dev/api/planets/2/" }, { "name": "Yavin IV", "rotation_period": "24", "orbital_period": "4818", "diameter": "10200", "climate": "temperate, tropical", "gravity": "1 standard", "terrain": "jungle, rainforests", "surface_water": "8", "population": "1000", "residents": [], "films": [ "https://swapi.dev/api/films/1/" ], "created": "2014-12-10T11:37:19.144000Z", "edited": "2014-12-20T20:58:18.421000Z", "url": "https://swapi.dev/api/planets/3/" }, { "name": "Hoth", "rotation_period": "23", "orbital_period": "549", "diameter": "7200", "climate": "frozen", "gravity": "1.1 standard", "terrain": "tundra, ice caves, mountain ranges", "surface_water": "100", "population": "unknown", "residents": [], "films": [ "https://swapi.dev/api/films/2/" ], "created": "2014-12-10T11:39:13.934000Z", "edited": "2014-12-20T20:58:18.423000Z", "url": "https://swapi.dev/api/planets/4/" }, { "name": "Dagobah", "rotation_period": "23", "orbital_period": "341", "diameter": "8900", "climate": "murky", "gravity": "N/A", "terrain": "swamp, jungles", "surface_water": "8", "population": "unknown", "residents": [], "films": [ "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/6/" ], "created": "2014-12-10T11:42:22.590000Z", "edited": "2014-12-20T20:58:18.425000Z", "url": "https://swapi.dev/api/planets/5/" }, { "name": "Bespin", "rotation_period": "12", "orbital_period": "5110", "diameter": "118000", "climate": "temperate", "gravity": "1.5 (surface), 1 standard (Cloud City)", "terrain": "gas giant", "surface_water": "0", "population": "6000000", "residents": [ "https://swapi.dev/api/people/26/" ], "films": [ "https://swapi.dev/api/films/2/" ], "created": "2014-12-10T11:43:55.240000Z", "edited": "2014-12-20T20:58:18.427000Z", "url": "https://swapi.dev/api/planets/6/" }, { "name": "Endor", "rotation_period": "18", "orbital_period": "402", "diameter": "4900", "climate": "temperate", "gravity": "0.85 standard", "terrain": "forests, mountains, lakes", "surface_water": "8", "population": "30000000", "residents": [ "https://swapi.dev/api/people/30/" ], "films": [ "https://swapi.dev/api/films/3/" ], "created": "2014-12-10T11:50:29.349000Z", "edited": "2014-12-20T20:58:18.429000Z", "url": "https://swapi.dev/api/planets/7/" }, { "name": "Naboo", "rotation_period": "26", "orbital_period": "312", "diameter": "12120", "climate": "temperate", "gravity": "1 standard", "terrain": "grassy hills, swamps, forests, mountains", "surface_water": "12", "population": "4500000000", "residents": [ "https://swapi.dev/api/people/3/", "https://swapi.dev/api/people/21/", "https://swapi.dev/api/people/35/", "https://swapi.dev/api/people/36/", "https://swapi.dev/api/people/37/", "https://swapi.dev/api/people/38/", "https://swapi.dev/api/people/39/", "https://swapi.dev/api/people/42/", "https://swapi.dev/api/people/60/", "https://swapi.dev/api/people/61/", "https://swapi.dev/api/people/66/" ], "films": [ "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "created": "2014-12-10T11:52:31.066000Z", "edited": "2014-12-20T20:58:18.430000Z", "url": "https://swapi.dev/api/planets/8/" }, { "name": "Coruscant", "rotation_period": "24", "orbital_period": "368", "diameter": "12240", "climate": "temperate", "gravity": "1 standard", "terrain": "cityscape, mountains", "surface_water": "unknown", "population": "1000000000000", "residents": [ "https://swapi.dev/api/people/34/", "https://swapi.dev/api/people/55/", "https://swapi.dev/api/people/74/" ], "films": [ "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "created": "2014-12-10T11:54:13.921000Z", "edited": "2014-12-20T20:58:18.432000Z", "url": "https://swapi.dev/api/planets/9/" }, { "name": "Kamino", "rotation_period": "27", "orbital_period": "463", "diameter": "19720", "climate": "temperate", "gravity": "1 standard", "terrain": "ocean", "surface_water": "100", "population": "1000000000", "residents": [ "https://swapi.dev/api/people/22/", "https://swapi.dev/api/people/72/", "https://swapi.dev/api/people/73/" ], "films": [ "https://swapi.dev/api/films/5/" ], "created": "2014-12-10T12:45:06.577000Z", "edited": "2014-12-20T20:58:18.434000Z", "url": "https://swapi.dev/api/planets/10/" } ] }'))
      .results;
  List<People> people = PeopleResponse.fromJson(jsonDecode(
          '{ "count": 82, "next": "https://swapi.dev/api/people/?page=2", "previous": null, "results": [ { "name": "Luke Skywalker", "height": "172", "mass": "77", "hair_color": "blond", "skin_color": "fair", "eye_color": "blue", "birth_year": "19BBY", "gender": "male", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [ "https://swapi.dev/api/vehicles/14/", "https://swapi.dev/api/vehicles/30/" ], "starships": [ "https://swapi.dev/api/starships/12/", "https://swapi.dev/api/starships/22/" ], "created": "2014-12-09T13:50:51.644000Z", "edited": "2014-12-20T21:17:56.891000Z", "url": "https://swapi.dev/api/people/1/" }, { "name": "C-3PO", "height": "167", "mass": "75", "hair_color": "n/a", "skin_color": "gold", "eye_color": "yellow", "birth_year": "112BBY", "gender": "n/a", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "species": [ "https://swapi.dev/api/species/2/" ], "vehicles": [], "starships": [], "created": "2014-12-10T15:10:51.357000Z", "edited": "2014-12-20T21:17:50.309000Z", "url": "https://swapi.dev/api/people/2/" }, { "name": "R2-D2", "height": "96", "mass": "32", "hair_color": "n/a", "skin_color": "white, blue", "eye_color": "red", "birth_year": "33BBY", "gender": "n/a", "homeworld": "https://swapi.dev/api/planets/8/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "species": [ "https://swapi.dev/api/species/2/" ], "vehicles": [], "starships": [], "created": "2014-12-10T15:11:50.376000Z", "edited": "2014-12-20T21:17:50.311000Z", "url": "https://swapi.dev/api/people/3/" }, { "name": "Darth Vader", "height": "202", "mass": "136", "hair_color": "none", "skin_color": "white", "eye_color": "yellow", "birth_year": "41.9BBY", "gender": "male", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [], "starships": [ "https://swapi.dev/api/starships/13/" ], "created": "2014-12-10T15:18:20.704000Z", "edited": "2014-12-20T21:17:50.313000Z", "url": "https://swapi.dev/api/people/4/" }, { "name": "Leia Organa", "height": "150", "mass": "49", "hair_color": "brown", "skin_color": "light", "eye_color": "brown", "birth_year": "19BBY", "gender": "female", "homeworld": "https://swapi.dev/api/planets/2/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [ "https://swapi.dev/api/vehicles/30/" ], "starships": [], "created": "2014-12-10T15:20:09.791000Z", "edited": "2014-12-20T21:17:50.315000Z", "url": "https://swapi.dev/api/people/5/" }, { "name": "Owen Lars", "height": "178", "mass": "120", "hair_color": "brown, grey", "skin_color": "light", "eye_color": "blue", "birth_year": "52BBY", "gender": "male", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [], "starships": [], "created": "2014-12-10T15:52:14.024000Z", "edited": "2014-12-20T21:17:50.317000Z", "url": "https://swapi.dev/api/people/6/" }, { "name": "Beru Whitesun lars", "height": "165", "mass": "75", "hair_color": "brown", "skin_color": "light", "eye_color": "blue", "birth_year": "47BBY", "gender": "female", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [], "starships": [], "created": "2014-12-10T15:53:41.121000Z", "edited": "2014-12-20T21:17:50.319000Z", "url": "https://swapi.dev/api/people/7/" }, { "name": "R5-D4", "height": "97", "mass": "32", "hair_color": "n/a", "skin_color": "white, red", "eye_color": "red", "birth_year": "unknown", "gender": "n/a", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/" ], "species": [ "https://swapi.dev/api/species/2/" ], "vehicles": [], "starships": [], "created": "2014-12-10T15:57:50.959000Z", "edited": "2014-12-20T21:17:50.321000Z", "url": "https://swapi.dev/api/people/8/" }, { "name": "Biggs Darklighter", "height": "183", "mass": "84", "hair_color": "black", "skin_color": "light", "eye_color": "brown", "birth_year": "24BBY", "gender": "male", "homeworld": "https://swapi.dev/api/planets/1/", "films": [ "https://swapi.dev/api/films/1/" ], "species": [], "vehicles": [], "starships": [ "https://swapi.dev/api/starships/12/" ], "created": "2014-12-10T15:59:50.509000Z", "edited": "2014-12-20T21:17:50.323000Z", "url": "https://swapi.dev/api/people/9/" }, { "name": "Obi-Wan Kenobi", "height": "182", "mass": "77", "hair_color": "auburn, white", "skin_color": "fair", "eye_color": "blue-gray", "birth_year": "57BBY", "gender": "male", "homeworld": "https://swapi.dev/api/planets/20/", "films": [ "https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/4/", "https://swapi.dev/api/films/5/", "https://swapi.dev/api/films/6/" ], "species": [], "vehicles": [ "https://swapi.dev/api/vehicles/38/" ], "starships": [ "https://swapi.dev/api/starships/48/", "https://swapi.dev/api/starships/59/", "https://swapi.dev/api/starships/64/", "https://swapi.dev/api/starships/65/", "https://swapi.dev/api/starships/74/" ], "created": "2014-12-10T16:16:29.192000Z", "edited": "2014-12-20T21:17:50.325000Z", "url": "https://swapi.dev/api/people/10/" } ] }'))
      .results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Text(
                    items.elementAt(index).name,
                    style:
                        const TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  child: Column(
                    children:[
                      Container(
                         decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                        'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg',
                                        width: 150)),
                        Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        people
                                            .elementAt(index)
                                            .name
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),

                    ]
                    )
                                    
                                
                
              )
              );
              },
          ),
        )
      ]),
      backgroundColor: Colors.redAccent,
    );
  }
}
