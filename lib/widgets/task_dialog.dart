import 'package:flutter/material.dart';
import 'package:scrumboard/global/global.dart';
import 'package:scrumboard/models/task_model.dart';
import 'package:scrumboard/models/task_priority_model.dart';
import 'package:scrumboard/services/local_storage_service.dart';
import '../main.dart';
import '../services/firebase_db_service.dart';
import 'package:uuid/uuid.dart';

class TaskDialogWidget extends StatefulWidget {
  final TaskModel? task;
  const TaskDialogWidget({super.key, this.task});

  @override
  State<TaskDialogWidget> createState() => _TaskDialogWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _TaskDialogWidgetState extends State<TaskDialogWidget> {
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

  late bool isExistingCard = false;
  late var dialogTitle;

  @override
  void initState() {
    super.initState();
    selectedPriority = priorities[0];
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
            child: const Text('Delete'),
            onPressed: () {
              db.DeleteTaskFromDb(tasks, widget.task!);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScrumboardMainScreen(),
              ));
            },
          ),
          // IconButton(onPressed: db.DeleteTaskFromDb(cards, widget.task), icon: Icon(Icons.delete)),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm'),
            onPressed: () {
              var guidGenerator = const Uuid();
              final title = titleController.text;
              final description = descriptionController.text;
              final user = userController.text;
              final priority = selectedPriority;
              final ident = guidGenerator.v1();
              const type = "TO DO";

              var newCard = TaskModel(
                  ident: ident,
                  title: title,
                  description: description,
                  priority: priority.name,
                  status: type,
                  user: user,);

              if (!isExistingCard) {
                tasks.add(newCard);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScrumboardMainScreen(),
                ));
              } else {
                var cardIndex = tasks.indexWhere((element) => element.ident == widget.task!.ident);

                tasks[cardIndex] = TaskModel(
                    ident: widget.task!.ident,
                    title: title,
                    description: description,
                    priority: priority.name,
                    status: widget.task!.status,
                    user: user,
                );
              }
              db.saveTasksToDb(tasks);
              localStorage.saveTasksToLocalStorage(tasks);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScrumboardMainScreen(),
              ));
            },
          ),
        ],
      );
}
