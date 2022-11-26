import 'package:flutter/material.dart';
import 'package:scrumboard/models/card_model.dart';

import '../widgets/task_dialog.dart';

mixin NewCardDialog {
  Future<void> dialogBuilder(BuildContext context, CardModel? card) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return TaskDialogWidget(card: card);
      },
    );
  }
}
