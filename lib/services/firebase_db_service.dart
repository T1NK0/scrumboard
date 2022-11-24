import 'package:firebase_database/firebase_database.dart';

class FirebaseDbService {
  DatabaseReference ref = FirebaseDatabase.instance.ref("");
  Future<void> Set() async {
    await ref.set({
      "name": "John",
      "age": 18,
    });
  }
}
