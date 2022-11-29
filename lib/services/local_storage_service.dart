// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:scrumboard/models/card_model.dart';
//
// class FirebaseDbService {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     return directory.path;
//   }
//
//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/tasks.txt');
//   }
//
//   Future<File> writeCounter(List<CardModel> cards) async {
//     final file = await _localFile;
//
//     var tasksMap = cards.map((e) {
//       return {
//         'ident': e.ident,
//         'title': e.title,
//         'description': e.description,
//         'priority': e.priority,
//         'status': e.status,
//         'user': e.user,
//       };
//     }).toList();
//     // Write the file
//     return file.writeAsString(tasksMap);
//   }
//
//   Future<int> readCounter() async {
//     try {
//       final file = await _localFile;
//
//       // Read the file
//       final contents = await file.readAsString();
//
//       return int.parse(contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return 0;
//     }
//   }
// }