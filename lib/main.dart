import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const JungleApp());
}

class JungleApp extends StatelessWidget {
  const JungleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
