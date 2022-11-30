import 'package:flutter/material.dart';
import 'package:scrumboard/models/task_model.dart';

import '../mixin/mixin.dart';

class CardWidget extends StatefulWidget {
  final TaskModel card;
  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with NewCardDialog {

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          splashColor: Colors.amber,
          onTap: () {
            dialogBuilder(context, widget.card);
          },
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.code,
                  ),
                  title: Text(widget.card.title),
                  subtitle: Text(widget.card.description),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(widget.card.user),
                    const SizedBox(width: 8),
                    // Text(widget.card.priority),
                    if(widget.card.priority == 'Low')
                      Icon(Icons.priority_high, color: Colors.green),
                    if(widget.card.priority == 'Medium')
                      Icon(Icons.priority_high, color: Colors.amber),
                    if(widget.card.priority == 'High')
                      Icon(Icons.priority_high, color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
