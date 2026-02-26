import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // লেয়ার ১: ব্যাকগ্রাউন্ড 🖼️
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

          // লেয়ার ২: ক্যারেক্টার (মাঝখানে শুধু একটা ক্যারেক্টার) 🥷
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.person,
              size: 180, // ক্যারেক্টারটা একটু বড় করে দিলাম
              color: Colors.white,
            ),
          ),

          // লেয়ার ৩: ক্যারেক্টার লাইব্রেরি বাটন (বাম দিকে নিচে) 🎒
          Positioned(
            left: 30,
            bottom: 30,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                // পরে এখানে ক্লিক করলে Character Library স্ক্রিনে যাবে
              },
              icon: const Icon(Icons.people, color: Colors.white),
              label: const Text(
                "Character Library",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          // লেয়ার ৪: ম্যাপ এবং স্টার্ট বাটন (ডান দিকে নিচে) 🗺️ ▶️
          Positioned(
            right: 30,
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ম্যাপ সিলেক্ট অপশন (START বাটনের ওপরে)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.map, color: Colors.amber),
                      SizedBox(width: 10),
                      Text(
                        "Map: Jungle (Auto)",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15), // ম্যাপ এবং স্টার্ট বাটনের মাঝে একটু ফাঁকা জায়গা
                
                // START বাটন
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
