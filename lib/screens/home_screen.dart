import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌴 Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🏹 3D Character
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 450,
              child: ModelViewer(
                src: 'assets/models/archer.glb', // আপাতত ফিক্সড আর্চার মডেল
                alt: "Fantasy Character",
                autoRotate: true,
                autoRotateDelay: 0,
                cameraControls: true,
                disableZoom: false,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),

          // 🎒 Character Library Button
          Positioned(
            left: 20,
            bottom: 30,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
              onPressed: () {
                // Character Library Screen-এ যাবে
              },
              icon: const Icon(Icons.people, color: Colors.white),
              label: const Text("Library", style: TextStyle(color: Colors.white)),
            ),
          ),

          // 🗺️ Map & START Button
          Positioned(
            right: 20,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.map, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text("Map: Jungle", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
                  },
                  child: const Text("START", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}