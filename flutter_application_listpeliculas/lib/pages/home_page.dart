import 'package:flutter/material.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Favoritas',
      style: optionStyle,
    ),
    Text(
      'Index 2: Descargadas',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          toolbarHeight: 70,
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
                    width: MediaQuery.of(context).size.width * 0.65,
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
          _widgetOptions.elementAt(_selectedIndex)
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio',backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritas',backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_download), label: 'Descargadas',backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuración',backgroundColor: Colors.grey)
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}