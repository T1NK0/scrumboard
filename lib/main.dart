import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'services/firebase_db_service.dart';
import 'widgets/widgets.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/mixin/mixin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScrumboardApp());
}

class ScrumboardApp extends StatelessWidget {
  const ScrumboardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scrumboard(),
      );
}

class Scrumboard extends StatefulWidget {
  const Scrumboard({super.key});

  @override
  State<Scrumboard> createState() => _ScrumboardState();
}

class _ScrumboardState extends State<Scrumboard> with NewCardDialog {
  FirebaseDbService db = FirebaseDbService();

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
