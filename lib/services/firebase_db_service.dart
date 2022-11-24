import 'package:firebase_database/firebase_database.dart';
import 'package:scrumboard/models/card_model.dart';

class FirebaseDbService {
  DatabaseReference ref = FirebaseDatabase.instance.ref("");
  // Future<void> Set(CardModel card) async {
  //   await ref.set([
  //     {
  //       "title": card.title,
  //       "description": card.description,
  //       "priority": card.priority,
  //       "status": 'todo',
  //       "user": card.user
  //     }
  //   ]);
  Future<void> Set() async {
    await ref.set({
      'tasks': [
        {
          "title": "Test1",
          "description": "This is a test for test 1",
          "priority": 'low',
          "status": 'todo',
          "user": "Tinko"
        },
        {
          "title": "Test2",
          "description": "This is a test for test 2",
          "priority": 'Medium',
          "status": 'inprogress',
          "user": "Steffen"
        },
        {
          "title": "Test3",
          "description": "This is a test for test 3",
          "priority": 'high',
          "status": 'testing',
          "user": "Steffen"
        },
        {
          "title": "Test4",
          "description": "This is a test for test 4",
          "priority": 'high',
          "status": 'done',
          "user": "Tinko"
        }
      ]
    });
  }
}
