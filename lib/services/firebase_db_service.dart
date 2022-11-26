import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrumboard/models/card_model.dart';

class FirebaseDbService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  List<CardModel> tasks = [];

  FirebaseDbService() {
    getDbData();
  }

  Future<void> saveTaskToDb(List<CardModel> tasks) async {
    var result = jsonEncode(tasks);
    await _dbRef.set(result);
    debugPrint('data');
  }

  Future<List<CardModel>> getDbData() async {
    var event = await _dbRef.once();

    var convertedToJson = jsonEncode(event.snapshot.value);

    List decodedJson = jsonDecode(convertedToJson);
    return _parseTasks(decodedJson);
  }

  List<CardModel> _parseTasks(List response) {
    return response.map<CardModel>((json) => CardModel.fromJson(json)).toList();
  }
}
