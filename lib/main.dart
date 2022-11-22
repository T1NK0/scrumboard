import 'package:flutter/material.dart';
import 'widgets/drawer.dart';

void main() {
  runApp(const Scrumboard());
}

class Scrumboard extends StatelessWidget {
  const Scrumboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Allows us to add UI elements to the screen.
        home: Scaffold(
      //A navigation bar (appbar)
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Scrumboard'),
      ),

      drawer: const NavigationDrawer(),
    ));
  }
}
