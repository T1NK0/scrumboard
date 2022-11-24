import 'package:firebase_database/firebase_database.dart';
import 'package:scrumboard/models/card_model.dart';

class FirebaseDbService {
  DatabaseReference ref = FirebaseDatabase.instance.ref("");
  Future<void> Set(CardModel card) async {
    await ref.set([
      {
        "title": card.title,
        "description": card.description,
        "priority": card.priority,
        "status": 'todo',
        "user": card.user
      }
    ]);
  }
}
