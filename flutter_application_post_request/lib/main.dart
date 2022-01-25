import 'package:flutter/material.dart';
import 'package:flutter_application_post_request/pages/auth_page.dart';
import 'package:flutter_application_post_request/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minitwitter',
      initialRoute: '/',
      routes: {
        '/register': (context)=> const AuthPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const LoginPage(),
    );
  }
}
