import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:scrumboard/models/swimlane_model.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/widgets/widgets.dart';

import '../services/firebase_db_service.dart';

FirebaseDbService db = FirebaseDbService();

class ScrumboardPage extends StatelessWidget {
  // List<CardModel> todoCards = getCards();
  // List<CardModel> inProgressCards = getCards();
  // List<CardModel> testingCards = getCards();
  // List<CardModel> doneCards = getCards();

  static List<CardModel> allCards = getCards();

  final List<Swimlane> _listData = [
    Swimlane(title: "TO DO", items: allCards),
    Swimlane(title: "IN PROGRESS", items: allCards),
    Swimlane(title: "TESTING", items: allCards),
    Swimlane(title: "DONE", items: allCards),
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

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

  Widget buildBoardItem(CardModel currentCard) {
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
      item: Center(
        child: CardWidget(key: key, card: currentCard),
      ),
    );
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
      headerBackgroundColor: Colors.grey[200],
      backgroundColor: Colors.grey[200],
      header: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              list.title!,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
      items: items,
    );
  }
}

List<CardModel> getCards() { 
  var data = db.getDbData();

  List<CardModel> tempData = CardModel.fromJson(List data);
  return tempData;
}
