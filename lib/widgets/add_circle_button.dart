import 'package:flutter/material.dart';
import 'widgets.dart';

class FloatActionButtonWidget extends StatelessWidget {
  const FloatActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {
          debugPrint('Test');
        },
        child: const Icon(Icons.add),
      );
}
