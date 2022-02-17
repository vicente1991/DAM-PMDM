import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: const HomeAppBar(),
            body: Container(),
      
    );
  }
}