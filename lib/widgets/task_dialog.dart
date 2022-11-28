import 'package:flutter/material.dart';
import 'package:scrumboard/global/global.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/models/task_priority_model.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import '../main.dart';
import '../services/firebase_db_service.dart';
import 'package:uuid/uuid.dart';

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

    if (widget.card != null) {
      isExistingCard = true;
      titleController.text = widget.card!.title;
      descriptionController.text = widget.card!.description;
      userController.text = widget.card!.user;
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
            child: const Text('Confirm'),
            onPressed: () {
              var guidGenerator = const Uuid();
              final title = titleController.text;
              final description = descriptionController.text;
              final user = userController.text;
              final priority = selectedPriority;
              if (!isExistingCard) {
                final ident = guidGenerator.v1();
                const type = "to do";
                cards.add(CardModel(
                    ident: ident,
                    title: title,
                    description: description,
                    priority: priority.name,
                    status: type,
                    user: user));

                dbSet.saveTasksToDb(cards);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scrumboard(),
                ));
              } else {
                cards.indexWhere((element) => false);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scrumboard(),
                ));
              }

              // dbSet.Set(widget.card!);
            },
          ),
        ],
      );
}
