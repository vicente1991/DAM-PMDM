import 'package:flutter/material.dart';

class PeopleDetailPage extends StatelessWidget {
  const PeopleDetailPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People Detail')),
      body: const Center(
        child: Text('People information'),
      ),
    );
  }
}