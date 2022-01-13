import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Viajes Dam';

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
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Card(
                child: InkWell(
                  splashColor: Colors.orange.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 350,
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 10),
                                child: RichText(
                                    text: const TextSpan(
                                        text: '20:55\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        children: [
                                      TextSpan(
                                          text: 'SALIDA',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10))
                                    ])),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 90, left: 10),
                                child: RichText(
                                    text: const TextSpan(
                                        text: '22:05\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        children: [
                                      TextSpan(
                                          text: 'LLEGADA',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10))
                                    ])),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 130),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(2)),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: 'MAD',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14))),
                                  ),
                                  RichText(
                                      text: const TextSpan(
                                          text: 'Madrid',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 130),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/logo.png', width: 50,),
                                      RichText(
                                                text: const TextSpan(
                                                    text: 'Iberia 7448',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13),
                                                        )),
                                    ],
                                  ),
                                  RichText(
                                                text: const TextSpan(
                                                    text: 'Duración 2h 10m',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13)))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 130),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(2)),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: 'LHR',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14))),
                                  ),
                                  RichText(
                                      text: const TextSpan(
                                          text: 'Londres',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}