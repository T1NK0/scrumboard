import 'package:flutter/material.dart';
import 'package:scrumboard/models/task_model.dart';
import 'package:scrumboard/services/local_storage_service.dart';
import '../main.dart';
import '../services/firebase_db_service.dart';

class ClearScrumboardWidget extends StatefulWidget {
  final TaskModel? task;
  const ClearScrumboardWidget({super.key, this.task});

  @override
  State<ClearScrumboardWidget> createState() => _ClearScrumboardWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _ClearScrumboardWidgetState extends State<ClearScrumboardWidget> {
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
