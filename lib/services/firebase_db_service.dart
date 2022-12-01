import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:scrumboard/models/task_model.dart';

class FirebaseDbService {
  final DatabaseReference _dbRefTasks = FirebaseDatabase.instance.ref('tasks');

  FirebaseDbService() {
    getDbData();
  }

  /// Saves the tasks to the database
  Future<void> saveTasksToDb(List<TaskModel> tasks) async {
    var tasksMap = tasks.map((e) {
      return {
        'ident': e.ident,
        'title': e.title,
        'description': e.description,
        'priority': e.priority,
        'status': e.status,
        'user': e.user,
      };
    }).toList();
    await _dbRefTasks.set(tasksMap);
  }

  /// Delete specified task from db.
  Future<void> deleteTaskFromDb(List<TaskModel> tasks, TaskModel selectedTask) async {
    tasks.removeWhere((element) => element.ident == selectedTask.ident);
    saveTasksToDb(tasks);
  }

  /// Get's all the data from the database.
  Future<List<TaskModel>> getDbData() async {
    var event = await _dbRefTasks.once();

    if (event.snapshot.value != null) {
      var convertedToJson = jsonEncode(event.snapshot.value);

      List decodedJson = jsonDecode(convertedToJson);
      return _parseTasks(decodedJson);
    } else {
      return [];
    }
  }

  /// removes the tasks from the db.
  Future<void> removeTasksFromDb() async {
    await _dbRefTasks.remove();
  }

  List<TaskModel> _parseTasks(List response) {
    return response.map<TaskModel>((json) => TaskModel.fromJson(json)).toList();
  }
}
