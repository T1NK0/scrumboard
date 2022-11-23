import 'package:flutter/material.dart';
import 'package:scrumboard/model/card_model.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          splashColor: Colors.teal,
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.filter_frames,
                    color: Colors.teal,
                    // size: 50,
                  ),
                  title: Text(widget.card.title),
                  subtitle: Text(widget.card.title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Priority: ${widget.card.priority}'),
                    const SizedBox(width: 8),
                    Text('Status: ${widget.card.status}'),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
