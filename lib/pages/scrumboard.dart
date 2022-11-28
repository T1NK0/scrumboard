import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:scrumboard/global/global.dart';
import 'package:scrumboard/models/swimlane_model.dart';
import 'package:scrumboard/models/card_model.dart';
import 'package:scrumboard/widgets/widgets.dart';

import '../services/firebase_db_service.dart';

class ScrumboardPage extends StatelessWidget {
  FirebaseDbService db = FirebaseDbService();
  late List<Swimlane> _listData;
  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  ScrumboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDataFromDatabase(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        cards = snapshot.data!;
        var listData = splitTasks(cards);

        List<BoardList> lists = [];
        for (int i = 0; i < listData.length; i++) {
          lists.add(_createBoardList(listData[i]) as BoardList);
        }

        return BoardView(
          lists: lists,
          boardViewController: boardViewController,
        );
      },
    );
  }

  Future<List<CardModel>> getDataFromDatabase() async {
    return await db.getDbData();
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

        currentCard.status = _listData[listIndex].title;
        var cardIndex = cards.indexWhere((element) => element.ident == currentCard.ident);
        cards[cardIndex] = currentCard;
        db.saveTasksToDb(cards);
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
            padding: const EdgeInsets.all(5),
            child: Text(
              list.title!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
      items: items,
    );
  }

  List<Swimlane> splitTasks(List<CardModel> allCards) {
    List<CardModel> todo = [];
    List<CardModel> inProgress = [];
    List<CardModel> testing = [];
    List<CardModel> done = [];

    debugPrint(allCards.toString());
    for (var card in allCards) {
      switch (card.status) {
        case "TO DO":
          todo.add(card);
          break;
        case "IN PROGRESS":
          inProgress.add(card);
          break;
        case "TESTING":
          testing.add(card);
          break;
        case "DONE":
          done.add(card);
          break;
        default:
      }
    }

    _listData = [
      Swimlane(title: "TO DO", items: todo),
      Swimlane(title: "IN PROGRESS", items: inProgress),
      Swimlane(title: "TESTING", items: testing),
      Swimlane(title: "DONE", items: done),
    ];

    return _listData;
  }
}
