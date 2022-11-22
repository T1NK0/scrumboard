import 'package:flutter/material.dart';
import 'package:scrumboard/widgets/swim_lane_header.dart';
import '../model/card_model.dart';

class ScrumboardPage extends StatefulWidget {
  const ScrumboardPage({super.key});

  @override
  State<ScrumboardPage> createState() => _ScrumboardPageState();
}

class _ScrumboardPageState extends State<ScrumboardPage> {
  List<CardModel> todoCards = getTodoCards();
  List<CardModel> inProgressCards = getInProgressCards();
  List<CardModel> testingCards = getTestingCards();
  List<CardModel> doneCards = getDoneCards();
  // List<CardModel> cards = getCards();

  static List<CardModel> getTodoCards() {
    const data = [
      {
        "title": "Test1",
        "description": "This is a test for test 1",
        "priority": 1,
        "status": 0,
        "user": "Tinko"
      },
      {
        "title": "Test1",
        "description": "This is a test for test 1",
        "priority": 1,
        "status": 0,
        "user": "Tinko"
      },
    ];
    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  static List<CardModel> getInProgressCards() {
    const data = [
      {
        "title": "Test2",
        "description": "This is a test for test 2",
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
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 2",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
    ];
    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  static List<CardModel> getTestingCards() {
    const data = [
      {
        "title": "Test3",
        "description": "This is a test for test 3",
        "priority": 1,
        "status": 0,
        "user": "Tinko"
      },
      {
        "title": "Test2",
        "description": "This is a test for test 3",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
    ];
    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  static List<CardModel> getDoneCards() {
    const data = [
      {
        "title": "Test4",
        "description": "This is a test for test 4",
        "priority": 1,
        "status": 0,
        "user": "Tinko"
      },
      {
        "title": "Test4",
        "description": "This is a test for test 4",
        "priority": 2,
        "status": 1,
        "user": "Steffen"
      },
    ];

    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(top: 15),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SwimLaneHeaderWidget(
                  title: 'To Do',
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    width: 350,
                    color: Colors.grey[200],
                    child: Container(
                      child: buildCards(todoCards),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(top: 15),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SwimLaneHeaderWidget(
                  title: 'In Development',
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    width: 350,
                    color: Colors.grey[200],
                    child: Container(
                      child: buildCards(inProgressCards),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(top: 15),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SwimLaneHeaderWidget(
                  title: 'Testing',
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    width: 350,
                    color: Colors.grey[200],
                    child: Container(
                      child: buildCards(testingCards),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(top: 15),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SwimLaneHeaderWidget(
                  title: 'Done',
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    width: 350,
                    color: Colors.grey[200],
                    child: Container(
                      child: buildCards(doneCards),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget buildCards(List<CardModel> cards) => ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
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
