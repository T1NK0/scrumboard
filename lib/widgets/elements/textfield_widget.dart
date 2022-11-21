import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'button_widget.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) => Center(
    child: ListView(
      padding: EdgeInsets.all(32),
      children: [
        const SizedBox(height: 24),
        ButtonWidget()
      ],
    ),
  )
  }
}