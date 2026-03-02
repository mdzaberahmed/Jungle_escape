import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GameScreen extends StatefulWidget {
  final String mapName; // 👈 লবি থেকে পাঠানো ম্যাপের নাম রিসিভ করার জন্য

  const GameScreen({super.key, required this.mapName});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🗺️ ৩ডি ম্যাপ লোড করা হচ্ছে
          const SizedBox.expand(
            child: ModelViewer(
              src: 'assets/models/map.glb', 
              alt: "Game Map",
              autoRotate: false,
              cameraControls: true,
              disableZoom: false,
              disablePan: false,
              backgroundColor: Colors.transparent,
            ),
          ),

          // 🔙 ব্যাক বাটন এবং ম্যাপের নাম (Top Left)
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context), // লবিতে ফিরে যাওয়ার জন্য
                ),
                const SizedBox(width: 10),
                Text(
                  "PLAYING ON: ${widget.mapName}", // 👈 এখানে সিলেক্ট করা ম্যাপের নাম দেখাবে
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          // 🕹️ ফায়ার বাটন বা জয়স্টিক (আপাতত ডামি ডিজাইন)
          Positioned(
            bottom: 30,
            right: 50,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () {
                // পরে এখানে গুলির লজিক হবে
              },
              child: const Icon(Icons.my_location, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
