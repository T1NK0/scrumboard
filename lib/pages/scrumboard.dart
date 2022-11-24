import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:scrumboard/models/swimlane_model.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/widgets/widgets.dart';

class ScrumboardPage extends StatelessWidget {
  List<CardModel> todoCards = getCards();
  List<CardModel> inProgressCards = getCards();
  List<CardModel> testingCards = getCards();
  List<CardModel> doneCards = getCards();

  static List<CardModel> getCards() {
    const data = [
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
      },
    ];
    return data.map<CardModel>(CardModel.fromJson).toList();
  }

  final List<Swimlane> _listData = [
    Swimlane(title: "TO DO", items: getCards()),
    Swimlane(title: "IN PROGRESS", items: getCards()),
    Swimlane(title: "TESTING", items: getCards()),
    Swimlane(title: "DONE", items: getCards()),
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
