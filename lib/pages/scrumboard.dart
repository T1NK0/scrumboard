import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

import 'package:scrumboard/model/swimlane_model.dart';
import 'package:scrumboard/model/card_model.dart';

class ScrumboardPage extends StatelessWidget {
  List<CardModel> todoCards = getCards();
  List<CardModel> inProgressCards = getCards();
  List<CardModel> testingCards = getCards();
  List<CardModel> doneCards = getCards();
  // List<CardModel> cards = getCards();

  static List<CardModel> getCards() {
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

  List<Swimlane> _listData = [
    Swimlane(title: "List title 1", items: getCards()),
    Swimlane(title: "List title 2", items: getCards()),
    Swimlane(title: "List title 3", items: getCards()),
    Swimlane(title: "List title 4", items: getCards()),
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
    return BoardView(
      lists: _lists,
      boardViewController: boardViewController,
    );
  }

  Widget buildBoardItem(CardModel itemObject) {
    return BoardItem(
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items![oldItemIndex!];
          _listData[oldListIndex].items!.removeAt(oldItemIndex!);
          _listData[listIndex!].items!.insert(itemIndex!, item);
        },
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject.title!),
          ),
        ));
  }

  Widget _createBoardList(Swimlane list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex!);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  list.title!,
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: items,
    );
  }
}
