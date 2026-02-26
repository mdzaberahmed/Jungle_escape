import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const JungleEscapeApp());
}

class JungleEscapeApp extends StatelessWidget {
  const JungleEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jungle Escape',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}