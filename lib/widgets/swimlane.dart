import 'package:flutter/material.dart';
import 'widgets.dart';

class SwimlaneWidget extends StatefulWidget {
  const SwimlaneWidget({super.key});

  @override
  State<SwimlaneWidget> createState() => _SwimlaneWidgetState();
}

class _SwimlaneWidgetState extends State<SwimlaneWidget> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey,
        width: 400,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
        padding: const EdgeInsets.only(top: 15),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const <Widget>[
            CardPostWidget(),
            CardPostWidget(),
            CardPostWidget(),
            CardPostWidget(),
            CardPostWidget(),
            CardPostWidget(),
          ],
        ),
      );
}
