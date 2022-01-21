import 'package:flutter/material.dart';

class Personajes extends StatelessWidget {
  const Personajes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: const Center(
        child: Text('People information'),
      ),
    );
  }
}