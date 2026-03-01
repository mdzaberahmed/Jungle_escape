import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // 📦 ক্যারেক্টারগুলোর লিস্ট (নাম, মডেলের লোকেশন এবং দাম)
  final List<Map<String, dynamic>> _characters = [
    {"name": "Gojo Style", "model": "assets/models/player.glb", "price": "Owned"},
    {"name": "Warrior Alpha", "model": "assets/models/char1.glb", "price": "2000 🪙"},
    {"name": "Cyber Ninja", "model": "assets/models/char2.glb", "price": "50 💎"},
    {"name": "Shadow Hunter", "model": "assets/models/char3.glb", "price": "100 💎"},
  ];

  int _currentIndex = 0; // বর্তমানে কোন ক্যারেক্টার দেখাচ্ছে তার ট্র্যাক রাখার জন্য

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🎨 ব্যাকগ্রাউন্ড
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF14002B), Color(0xFF000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔄 3D ক্যারেক্টার সোয়াইপ ভিউ (PageView)
          PageView.builder(
            itemCount: _characters.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index; // সোয়াইপ করলে ইনডেক্স আপডেট হবে
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: ModelViewer(
                    src: _characters[index]["model"], // লিস্ট থেকে মডেল লোড হবে
                    alt: "Character Model",
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    disablePan: true,
                    cameraOrbit: "0deg 85deg 25m",
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            },
          ),

          // 🔙 টপ বার (Back Button & Coins)
          Positioned(
            top: 20, left: 20, right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "STORE",
                  style: TextStyle(color: Colors.amber, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
                Row(
                  children: const [
                    Icon(Icons.monetization_on, color: Colors.amber), SizedBox(width: 5),
                    Text("5000", style: TextStyle(color: Colors.white)), SizedBox(width: 15),
                    Icon(Icons.diamond, color: Colors.blueAccent), SizedBox(width: 5),
                    Text("10", style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),

          // 💰 ক্যারেক্টারের নাম এবং দাম (Bottom Section)
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Column(
              children: [
                Text(
                  _characters[_currentIndex]["name"],
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 10),
                Text(
                  "Price: ${_characters[_currentIndex]["price"]}",
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                
                // BUY / EQUIP Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentIndex == 0 ? Colors.green : Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // পরে এখানে কেনার সিস্টেম যোগ করব
                  },
                  child: Text(
                    _currentIndex == 0 ? "EQUIPPED" : "PURCHASE",
                    style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // ⬅️ ➡️ সোয়াইপ ইন্ডিকেটর (Left / Right Arrows)
          Positioned(
            top: 250, left: 20,
            child: Icon(Icons.arrow_back_ios, color: Colors.white.withOpacity(0.5), size: 40),
          ),
          Positioned(
            top: 250, right: 20,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.5), size: 40),
          ),
        ],
      ),
    );
  }
}

