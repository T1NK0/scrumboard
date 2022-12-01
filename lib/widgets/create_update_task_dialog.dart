import 'package:flutter/material.dart';
import 'package:scrumboard/global/global.dart';
import 'package:scrumboard/models/task_model.dart';
import 'package:scrumboard/models/task_priority_model.dart';
import 'package:scrumboard/services/local_storage_service.dart';
import '../services/firebase_db_service.dart';
import 'package:uuid/uuid.dart';

class CreateUpdateTaskDialogWidget extends StatefulWidget {
  final TaskModel? task;
  const CreateUpdateTaskDialogWidget({super.key, this.task});

  @override
  State<CreateUpdateTaskDialogWidget> createState() => _CreateUpdateTaskDialogWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _CreateUpdateTaskDialogWidgetState extends State<CreateUpdateTaskDialogWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController userController;
  FirebaseDbService db = FirebaseDbService();
  LocalStorageService localStorage = LocalStorageService();

  late TaskPriority selectedPriority;
  List<TaskPriority> priorities = <TaskPriority>[
    const TaskPriority(1, 'Low'),
    const TaskPriority(2, 'Medium'),
    const TaskPriority(3, 'High')
  ];

  //Checks if the task already exists
  late bool isExistingCard = false;

  //Creates the title of the dialog.
  late var dialogTitle;

  /// Set the controllers of our form fields.
  /// Get's the data from the task selected if pressed through card, else give us a clean form.
  @override
  void initState() {
    super.initState();

    /// Logic to keep selected value on edit of task.
    if(widget.task == null) {
      selectedPriority = priorities[0];
    } else {
      var alreadySelectedPriority = priorities.indexWhere((element) => element.name == widget.task!.priority);
      selectedPriority = priorities[alreadySelectedPriority];
    }

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    userController = TextEditingController();

    if (widget.task != null) {
      isExistingCard = true;
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      userController.text = widget.task!.user;
      dialogTitle = 'Edit';
    } else {
      isExistingCard = false;
      dialogTitle = 'Create';
    }
  }


  /// Alertdialog with form to show, and logic on confirm wether to update the task, or create a new task.
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          dialogTitle,
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
                  isExpanded: true,
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
              Navigator.pop(context);
            },
          ),
          if(isExistingCard)
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete'),
              onPressed: () {
                tasks.removeWhere((element) => element.ident == widget.task!.ident);
                db.saveTasksToDb(tasks);
                Navigator.pop(context);
                setState(() {});
              },
            ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm'),
            onPressed: () {
              var guidGenerator = const Uuid();
              var newCard = TaskModel(
                  ident: guidGenerator.v1(),
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: selectedPriority.name,
                  status: 'TO DO',
                  user: userController.text,);

              if (isExistingCard) {
                newCard.status = widget.task!.status;
                newCard.ident = widget.task!.ident;
                tasks[tasks.indexWhere((element) => element.ident == widget.task!.ident)] = newCard;
              } else {
                tasks.add(newCard);
              }
              db.saveTasksToDb(tasks);
              Navigator.pop(context);
              setState(() {});
              // localStorage.saveTasksToLocalStorage(tasks);
            },
          ),
        ],
      );
}
