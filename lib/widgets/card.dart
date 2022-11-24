import 'package:flutter/material.dart';
import 'package:scrumboard/model/card_model.dart';

import '../mixin/mixin.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with NewCardDialog {
  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          splashColor: Colors.teal,
          onTap: () {
            dialogBuilder(context, widget.card);
            // Navigator.pop(context);

            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const TaskPage(),
            // ));
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.task,
                    color: Colors.teal,
                    // size: 50,dialogBuilder(context);
                  ),
                  title: Text(widget.card.title),
                  subtitle: Text(widget.card.title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.card.user,
                      style: TextStyle(),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.card.priority),
                    const SizedBox(width: 8),
                    Text(widget.card.status),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
