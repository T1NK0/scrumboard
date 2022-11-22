import 'package:flutter/material.dart';
import '../model/card_model.dart';

class SwimlaneWidget extends StatefulWidget {
  const SwimlaneWidget({super.key});

  @override
  State<SwimlaneWidget> createState() => _SwimlaneWidgetState();
}

class _SwimlaneWidgetState extends State<SwimlaneWidget> {
  List<CardModel> cards = getCards();

  static List<CardModel> getCards() {
    const data = [
      {
        "title": "Test1",
        "description": "This is a test for test 1",
        "priority": 1,
        "status": 0,
        "user": "Tinko"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test3",
        "description": "This is a test for test 3",
        "priority": 3,
        "status": 2,
        "user": "Steffen"
      },
      {
        "title": "Test4",
        "description": "This is a test fr test 4",
        "priority": 4,
        "status": 3,
        "user": "Tinko"
      }
    ];

    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey,
        width: 400,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
        padding: const EdgeInsets.only(top: 15),
        child: buildCard(cards),
      );

  Widget buildCard(List<CardModel> cards) => ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];

          return Card(
            child: ListTile(
              title: Text(card.title),
              subtitle: Text(card.description),
            ),
          );
        },
      );
}
