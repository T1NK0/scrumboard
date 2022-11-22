import 'package:flutter/material.dart';

class SwimLaneHeaderWidget extends StatelessWidget {
  const SwimLaneHeaderWidget({super.key, required this.title, required});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.green[400],
      child: Center(
        child: Text(title),
      ),
    );
  }
}
