import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Concesionario DAM';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: Text(
                    'El mas barato.Buena puntuación',
                    style: TextStyle(color: Colors.greenAccent[400]),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: Text('45 ofertas',
                      style: TextStyle(color: Colors.grey[400])),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
            Image.asset(
              'assets/images/image.png',
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240),
              child: RichText(
                  text: const TextSpan(
                      text: 'Mini UwU\n',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: [
                    TextSpan(
                        text: '2 puertas - Chevrolet amarillo\n',
                        style: TextStyle(color: Colors.grey, fontSize: 12))
                  ])),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.grain_rounded,
                          size: 15,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: RichText(
                              text: const TextSpan(
                                  text: 'Man.',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12))),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.ac_unit,
                          size: 15,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: RichText(
                              text: const TextSpan(
                                  text: 'A/A',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12))),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.group,
                          size: 15,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: RichText(
                              text: const TextSpan(
                                  text: '4',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12))),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 15,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: RichText(
                              text: const TextSpan(
                                  text: '1',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12))),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 18),
            const Divider(
              color: Colors.grey,
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: const Text('35.000€'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('SELECCIONAR'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
