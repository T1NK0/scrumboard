import 'package:flutter/material.dart';

class Boards extends StatelessWidget {
  const Boards({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Boards'),
        ),
      );
}
