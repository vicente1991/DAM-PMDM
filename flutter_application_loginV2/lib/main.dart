import 'package:flutter/material.dart';
import 'package:flutter_application_login/pages/register.dart';
import 'package:flutter_application_login/pages/signin_page.dart';

void main() {
  runApp(
    MaterialApp(
    title: 'Named Routes DAM',
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/register': (context) => Register(),
    },
  ));
}
