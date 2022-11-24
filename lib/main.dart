import 'package:flutter/material.dart';
import 'package:scrumboard/pages/login.dart';
import 'widgets/widgets.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/mixin/mixin.dart';

void main() {
  runApp(const ScrumboardApp());
}

class ScrumboardApp extends StatelessWidget {
  const ScrumboardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scrumboard(),
      );
}

class Scrumboard extends StatefulWidget {
  const Scrumboard({super.key});

  @override
  State<Scrumboard> createState() => _ScrumboardState();
}

class _ScrumboardState extends State<Scrumboard> with NewCardDialog {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Scrumboard'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  dialogBuilder(context, null);
                }),
          ],
        ),
        drawer: const NavigationDrawer(),
        body: ScrumboardPage(),
      );
}
