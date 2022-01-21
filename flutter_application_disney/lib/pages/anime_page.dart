import 'package:flutter/material.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animes')),
      body: const Center(
        child: Text('Anime Information'),
      ),
    );
  }
}