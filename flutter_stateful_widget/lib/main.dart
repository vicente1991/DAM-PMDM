import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _login = "Already have a Path account?";
  final String _password = "By using Path,you agree to Path´s";
  final String _Terms = "Terms of Use and Privacy Policy"; 

  

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/path_logo.png'
            ),
            const Padding(padding: EdgeInsets.only(bottom: 100)),
            SizedBox(width: 250, height: 60,
              child:ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                child: const Text('Sign up',
                style: TextStyle(color: Colors.redAccent, fontSize: 23.0, fontWeight: FontWeight.bold),),)
            ),
            const Padding(padding: EdgeInsets.only(bottom: 50)),
            Text(
              _login,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            
            const SizedBox(width: 250, height: 60,
              child:ElevatedButton(
                onPressed: null,
                child: Text('login'),)
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              _password,
              style: Theme.of(context).textTheme.subtitle2,
              ),
            Text(
              _Terms,
              style:Theme.of(context).textTheme.subtitle2 ,
              
            )
          ],
        ),
      ), 
      backgroundColor: const Color.fromRGBO(228, 51, 20, 1),
          );
  }
}
