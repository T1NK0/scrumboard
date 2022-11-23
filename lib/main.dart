import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/mixin/mixin.dart';

void main() {
  runApp(const Scrumboard());
}

class Scrumboard extends StatelessWidget with DialogBuilder {
  const Scrumboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      //Allows us to add UI elements to the screen.
      home: Scaffold(
        //A navigation bar (appbar)
        appBar: AppBar(
          title: const Text('Scrumboard'),
          actions: [
            IconButton(
              onPressed: () {
                dialogBuilder(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),

        drawer: const NavigationDrawer(),

        body: ScrumboardPage(),
      ),
    );
  }
}
