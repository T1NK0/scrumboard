import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:scrumboard/models/card_model.dart';

class LocalStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
    debugPrint(directory.path);
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.txt');
  }

  Future<File> saveTasksToLocalStorage(List<CardModel> tasks) async {
    final file = await _localFile;

    var convertedToJson = jsonEncode(tasks);

    // Write the file
    return file.writeAsString(convertedToJson);
  }

  Future<List<CardModel>> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      List decodedJson= jsonDecode(contents);
      return _parseTasks(decodedJson);
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }


  Future<void> deleteFile() async {
      final file = await _localFile;
      await file.delete();
  }

  List<CardModel> _parseTasks(List response) {
    return response.map<CardModel>((json) => CardModel.fromJson(json)).toList();
  }
}