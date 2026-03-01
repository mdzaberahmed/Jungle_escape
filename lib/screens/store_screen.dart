import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // 📦 ক্যারেক্টারগুলোর লিস্ট
  final List<Map<String, dynamic>> _characters = [
    {"name": "Gojo Style", "model": "assets/models/player.glb", "price": "Owned", "type": "coins"},
    {"name": "Warrior Alpha", "model": "assets/models/char1.glb", "price": "2000", "type": "coins"},
    {"name": "Cyber Ninja", "model": "assets/models/char2.glb", "price": "50", "type": "diamonds"},
    {"name": "Shadow Hunter", "model": "assets/models/char3.glb", "price": "100", "type": "diamonds"},
  ];

  int _selectedIndex = 0; // ডানদিকে কোন মডেল দেখাবে তার ইনডেক্স

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14002B), Color(0xFF000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 🔙 টপ বার (Back Button & Coins)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "STORE",
                    style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
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

            // 🔲 মেইন ৩-কলাম লেআউট
            Expanded(
              child: Row(
                children: [
                  // ⬅️ ১. বাম দিক (Left Menu) - flex: 2 মানে এটি ২ ভাগ জায়গা নেবে
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMenuButton("FASHION", true),
                          _buildMenuButton("COLLECTION", false),
                          _buildMenuButton("WEAPON", false),
                          _buildMenuButton("ITEM", false),
                        ],
                      ),
                    ),
                  ),

                  // 🔲 ২. মাঝখান (Center Grid) - flex: 5 মানে এটি সবচেয়ে বড় (৫ ভাগ) জায়গা নেবে
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _characters.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              // এখানে ক্লিক করলে ডানদিকের মডেল আপডেট হবে
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                border: Border.all(
                                  color: isSelected ? Colors.amber : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.person, size: 50, color: Colors.white54), // এখানে পরে 2D ছবি দেওয়া যাবে
                                  const SizedBox(height: 10),
                                  Text(_characters[index]["name"], style: const TextStyle(color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _characters[index]["type"] == "diamonds" ? Icons.diamond : Icons.monetization_on,
                                        color: _characters[index]["type"] == "diamonds" ? Colors.blueAccent : Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(_characters[index]["price"], style: const TextStyle(color: Colors.white70)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // ➡️ ৩. ডান দিক (Right Preview) - flex: 4 মানে এটি ৪ ভাগ জায়গা নেবে
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: ModelViewer(
                            key: ValueKey(_characters[_selectedIndex]["model"]), // মডেল রিফ্রেশ করার জন্য
                            src: _characters[_selectedIndex]["model"],
                            alt: "Character Model",
                            autoRotate: true,
                            cameraControls: true,
                            disableZoom: true,
                            disablePan: true,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            // কেনার লজিক এখানে বসবে
                          },
                          child: const Text(
                            "PURCHASE",
                            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // বাম দিকের মেনু বাটন বানানোর ছোট ফাংশন
  Widget _buildMenuButton(String title, bool isSelected) {
    return Container(
      width: double.infinity,
      color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.amber : Colors.white,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
