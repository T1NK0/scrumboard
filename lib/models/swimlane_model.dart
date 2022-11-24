import 'package:scrumboard/models/card_model.dart';

class Swimlane {
  String title;
  List<CardModel> items;

  Swimlane({
    required this.title,
    required this.items,
  });
}
