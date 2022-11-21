import 'package:flutter/material.dart';
import 'package:scrumboard/main.dart';
import 'package:scrumboard/pages/boards.dart';
import 'package:scrumboard/pages/login.dart';
import 'package:scrumboard/pages/user.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));
}

Widget buildHeader(BuildContext context) => Material(
    color: Colors.red.shade400,
    child: InkWell(
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const User(),
          ));
        },
        child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage('assets/images/standard_user.png'),
                ),
                SizedBox(height: 12),
                Text(
                  'Mads Tinko',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  'mads8340@zbc.dk',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ))));

Widget buildMenuItems(BuildContext context) => Column(
      children: [
        ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Hjem'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Scrumboard(),
                ))),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Boards'),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Boards(),
            ));
          },
        ),
        ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Login(),
              ));
            }),
      ],
    );
