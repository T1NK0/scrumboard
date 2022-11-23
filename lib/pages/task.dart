import 'package:flutter/material.dart';

import '../widgets/form.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        // body: TaskFormWidget()
      );
}
