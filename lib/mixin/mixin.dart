import 'package:flutter/material.dart';
import 'package:scrumboard/models/task_model.dart';

import '../widgets/task_dialog.dart';

mixin NewCardDialog {
  Future<void> dialogBuilder(BuildContext context, TaskModel? card) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return TaskDialogWidget(task: card);
      },
    );
  }
}
