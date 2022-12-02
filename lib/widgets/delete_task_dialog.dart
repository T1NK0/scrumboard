import 'package:flutter/material.dart';

class DeleteTaskDialogWidget extends StatelessWidget {
  const DeleteTaskDialogWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      'Clear board',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      MaterialButton(
        color: Colors.amber,
        textColor: Colors.black,
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
          setState(() {

          });
        },
      ),
      MaterialButton(
        color: Colors.amber,
        textColor: Colors.black,
        child: const Text('Confirm'),
        onPressed: () {


          Navigator.pop(context);
          setState(() {

          });
        },
      ),
    ],
  );
  }
}
