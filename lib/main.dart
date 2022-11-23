import 'package:flutter/material.dart';
import 'package:scrumboard/pages/task.dart';
import 'widgets/widgets.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/mixin/mixin.dart';

void main() {
  runApp(const Scrumboard());
}

class Scrumboard extends StatelessWidget with NewCardDialog {
  const Scrumboard({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        //Allows us to add UI elements to the screen.
        home: Scaffold(
          //A navigation bar (appbar)
          appBar: AppBar(
            title: const Text('Scrumboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  dialogBuilder(context, null);

                  // Navigator.pop(context);

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  // builder: (context) => const TaskPage(),
                  // ),
                  // );
                },
              ),
            ],
          ),

          drawer: const NavigationDrawer(),

          body: ScrumboardPage(),
        ),
      );
}
