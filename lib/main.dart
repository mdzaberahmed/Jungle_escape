import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // HomeScreen ইমপোর্ট করা হলো

void main() {
  runApp(const JungleEscapeApp());
}

class JungleEscapeApp extends StatelessWidget {
  const JungleEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jungle Escape',
      theme: ThemeData(
        primarySwatch: Colors.green, // জঙ্গলের থিম
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // গেম চালু হলেই প্রথমে লবি বা HomeScreen দেখাবে
    );
  }
}
