import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/ui/pages/menu_screen.dart';
import 'package:flutter_application_miarmapp/ui/widgets/post_widget.dart';
import 'package:flutter_application_miarmapp/ui/pages/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PostWidget(),
        '/menu': (context) => const MenuScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
