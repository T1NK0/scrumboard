import 'package:flutter/material.dart';
import 'package:scrumboard/global/global.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/models/task_priority_model.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/services/local_storage_service.dart';
import '../main.dart';
import '../services/firebase_db_service.dart';
import 'package:uuid/uuid.dart';

class DeleteDialogWidget extends StatefulWidget {
  final CardModel? card;
  const DeleteDialogWidget({super.key, this.card});

  @override
  State<DeleteDialogWidget> createState() => _DeleteDialogWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _DeleteDialogWidgetState extends State<DeleteDialogWidget> {
  FirebaseDbService db = FirebaseDbService();
  LocalStorageService localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();
  }

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
    content: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Row( children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm'),
            onPressed: () {
                db.removeTasksFromDb();
                localStorage.deleteFile();

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScrumboardMainScreen(),
                ));
            },
          ),
        ],
        ),
      ),
    ),
  );
}
