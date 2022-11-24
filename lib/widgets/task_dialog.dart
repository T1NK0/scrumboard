import 'package:flutter/material.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:scrumboard/model/card_model.dart';

class TaskDialogWidget extends StatefulWidget {
  final CardModel? card;
  const TaskDialogWidget({super.key, this.card});

  @override
  State<TaskDialogWidget> createState() => _TaskDialogWidgetState();
}

// var status = <String, String>{
//   'todo': 'To do',
//   'inprogress': 'In progress',
//   'testing': 'Testing',
//   'done': 'Done',
// };

// const List<String> priority = <String>['One', 'Two', 'Three', 'Four'];

class _TaskDialogWidgetState extends State<TaskDialogWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController userController;

  // String statusDropdownValue = status.first;
  // String priorityDropdownValue = priority.first;

  @override
  void initState() {
    super.initState();

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
        title: Text(
          'Edet Task',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
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
                    icon: Icon(Icons.close),
                    onPressed: () => titleController.clear(),
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 15),
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
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 15),
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  hintText: 'User ontask',
                  labelText: 'User',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => userController.clear(),
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              // SizedBox(height: 15),
              // DropdownButton<String>(
              //   value: priorityDropdownValue,
              //   icon: const Icon(Icons.arrow_downward),
              //   elevation: 16,
              //   style: const TextStyle(color: Colors.teal),
              //   underline: Container(
              //     height: 2,
              //     color: Colors.teal,
              //   ),
              //   onChanged: (String? value) {
              //     // This is called when the user selects an item.
              //     setState(() {
              //       priorityDropdownValue = value!;
              //     });
              //   },
              //   items: priority.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
              // SizedBox(height: 15),
              // DropdownButton<String>(
              //   value: statusDropdownValue,
              //   icon: const Icon(Icons.arrow_downward),
              //   elevation: 16,
              //   style: const TextStyle(color: Colors.teal),
              //   underline: Container(
              //     height: 2,
              //     color: Colors.teal,
              //   ),
              //   onChanged: (String? value) {
              //     // This is called when the user selects an item.
              //     setState(() {
              //       statusDropdownValue = value!;
              //     });
              //   },
              //   items: status.map<DropdownMenuItem<T>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
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
