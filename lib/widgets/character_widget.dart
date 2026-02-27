import 'package:flutter/material.dart';
import 'dart:math';

class CharacterWidget extends StatefulWidget {
  final bool isBoy;
  const CharacterWidget({super.key, required this.isBoy});

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          angle += details.delta.dx * 0.01;
        });
      },
      child: Transform.rotate(
        angle: angle,
        child: Icon(
          widget.isBoy ? Icons.person : Icons.person_2,
          size: 180,
          color: Colors.orange,
        ),
      ),
    );
  }
}