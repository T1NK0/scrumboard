import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrumboard/models/card_model.dart';

class FirebaseDbService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('tasks');

  List<CardModel> tasks = [];

  FirebaseDbService() {
    getDbData();
  }

  Future<void> saveTasksToDb(List<CardModel> tasks) async {
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
    await _dbRef.set(tasksMap);
  }

  Future<List<CardModel>> getDbData() async {
    var event = await _dbRef.once();

    if (event.snapshot.value != null) {
      var convertedToJson = jsonEncode(event.snapshot.value);

      List decodedJson = jsonDecode(convertedToJson);
      return _parseTasks(decodedJson);
    } else {
      return [];
    }
  }

  List<CardModel> _parseTasks(List response) {
    return response.map<CardModel>((json) => CardModel.fromJson(json)).toList();
  }
}
