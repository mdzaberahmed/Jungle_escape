import 'package:flutter/material.dart';
import 'game_screen.dart'; // গেম স্ক্রিন ইমপোর্ট করা হলো

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // লেয়ার ১: ব্যাকগ্রাউন্ড
          Container(
            color: Colors.green.shade900,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Text(
                "Jungle Background",
                style: TextStyle(color: Colors.white54, fontSize: 20),
              ),
            ),
          ),

          // লেয়ার ২: ক্যারেক্টার (আপাতত আইকন)
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.person_standing,
              size: 150,
              color: Colors.white,
            ),
          ),

          // লেয়ার ৩: START বাটন
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // START-এ ক্লিক করলে GameScreen-এ যাবে
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text(
                "START",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

