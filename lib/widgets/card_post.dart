import 'package:flutter/material.dart';

class CardPostWidget extends StatefulWidget {
  const CardPostWidget({super.key});

  @override
  State<CardPostWidget> createState() => _CardPostWidgetState();
}

class _CardPostWidgetState extends State<CardPostWidget> {
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        // child: Container(
        //   padding: const EdgeInsets.all(16),
        //   child: Column(children: const [
        //     Text(
        //       'The definition of insanity, is doing the same shit, over and over. And expecting different',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //     SizedBox(height: 12),
        //     Text('Tinko'),
        //   ]),
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      );
}
