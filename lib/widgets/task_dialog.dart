import 'package:flutter/material.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/models/task_priority_model.dart';
import '../services/firebase_db_service.dart';

class TaskDialogWidget extends StatefulWidget {
  final CardModel? card;
  const TaskDialogWidget({super.key, this.card});

  @override
  State<TaskDialogWidget> createState() => _TaskDialogWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _TaskDialogWidgetState extends State<TaskDialogWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController userController;
  FirebaseDbService dbSet = FirebaseDbService();

  late final TaskPriority selectedPriority;
  List<TaskPriority> priorities = <TaskPriority>[
    const TaskPriority(1, 'Low'),
    const TaskPriority(2, 'Medium'),
    const TaskPriority(3, 'High')
  ];

  @override
  void initState() {
    super.initState();
    selectedPriority = priorities[0];
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    userController = TextEditingController();

    if (widget.card != null) {
      titleController.text = widget.card!.title;
      descriptionController.text = widget.card!.description;
      userController.text = widget.card!.user;
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(
          'Edet Task',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title Of task',
                    labelText: 'Title',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => titleController.clear(),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'description Of task',
                    labelText: 'Description',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => descriptionController.clear(),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: 'User ontask',
                    labelText: 'User',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => userController.clear(),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                DropdownButton<TaskPriority>(
                  value: selectedPriority,
                  onChanged: (TaskPriority? newValue) {
                    setState(() {
                      selectedPriority = newValue!;
                    });
                  },
                  items: priorities.map((TaskPriority taskPriority) {
                    return DropdownMenuItem<TaskPriority>(
                      value: taskPriority,
                      child: Text(
                        taskPriority.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
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
            child: const Text('Create'),
            onPressed: () {
              final title = titleController.text;
              final description = titleController.text;
              final user = titleController.text;
              final priority = selectedPriority;
              final type = "todo";

              Navigator.of(context).pop();
              // dbSet.Set(widget.card!);
            },
          ),
        ],
      );
}
