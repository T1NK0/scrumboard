import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

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
          backgroundColor: Colors.red[400],
          title: const Text('Scrumboard'),
        ),

        drawer: const NavigationDrawer(),

        body: ListView(
          scrollDirection: Axis.horizontal,
          children: const <Widget>[
            SwimlaneWidget(),
            SwimlaneWidget(),
            SwimlaneWidget(),
            SwimlaneWidget(),
          ],
        ),
        floatingActionButton: FloatActionButtonWidget(),
      ),
    );
  }
}
