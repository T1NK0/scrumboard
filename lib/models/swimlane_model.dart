import 'package:scrumboard/models/task_model.dart';

class Swimlane {
  String title;
  List<TaskModel> items;

  Swimlane({
    required this.title,
    required this.items,
  });
}
