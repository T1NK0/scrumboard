import 'package:flutter/material.dart';

class TaskDialogWidget extends StatefulWidget {
  const TaskDialogWidget({super.key});

  @override
  State<TaskDialogWidget> createState() => _TaskDialogWidgetState();
}

class _TaskDialogWidgetState extends State<TaskDialogWidget> {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Basic dialog title'),
        content: const Text('A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}
