import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/task_dialog.dart';

mixin DialogBuilder {
  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return TaskDialogWidget();
      },
    );
  }
}
