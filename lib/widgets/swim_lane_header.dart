import 'package:flutter/material.dart';

class SwimLaneHeaderWidget extends StatelessWidget {
  const SwimLaneHeaderWidget({super.key, required this.title, required});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blueGrey[900],
      child: Center(
        child: Text(title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
      ),
    );
  }
}
