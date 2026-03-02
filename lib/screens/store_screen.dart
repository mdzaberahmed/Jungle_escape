import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // 💰 প্লেয়ারের বর্তমান ব্যালেন্স
  int _coins = 5000;
  int _diamonds = 10;

  // 📂 নির্বাচিত ক্যাটাগরি
  String _selectedCategory = "CHARACTER";

  // 📦 স্টোরের আইটেম লিস্ট (তোমার ছবির নাম অনুযায়ী আপডেট করা হয়েছে)
  final List<Map<String, dynamic>> _items = [
    {"name": "Gojo Style", "model": "assets/models/player.glb", "icon": "assets/images/Gojo Style.png", "price": 0, "type": "coins", "category": "CHARACTER", "isOwned": true},
    {"name": "Warrior Alpha", "model": "assets/models/char1.glb", "icon": "assets/images/Warrior Alpha.png", "price": 2000, "type": "coins", "category": "CHARACTER", "isOwned": false},
    {"name": "Cyber Ninja", "model": "assets/models/char2.glb", "icon": "assets/images/Cyber Ninja.png", "price": 50, "type": "diamonds", "category": "CHARACTER", "isOwned": false},
    {"name": "Shadow Hunter", "model": "assets/models/char3.glb", "icon": "assets/images/Shadow Hunter.png", "price": 100, "type": "diamonds", "category": "CHARACTER", "isOwned": false},
    
    // --- Weapons & Pets ---
    {"name": "Katana Blade", "model": "assets/models/sword.glb", "price": 300, "type": "diamonds", "category": "WEAPON", "isOwned": false},
    {"name": "Fire Phoenix", "model": "assets/models/phoenix_bird.glb", "price": 500, "type": "diamonds", "category": "PET", "isOwned": false},
  ];

  int _selectedIndex = 0;

  // 🛒 কেনার লজিক
  void _purchaseItem(Map<String, dynamic> item) {
    if (item["isOwned"]) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You already own this item!"), backgroundColor: Colors.blue));
      return;
    }

    setState(() {
      if (item["type"] == "coins") {
        if (_coins >= item["price"]) {
          _coins -= item["price"] as int;
          item["isOwned"] = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully purchased ${item["name"]}!"), backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough Coins!"), backgroundColor: Colors.red));
        }
      } else if (item["type"] == "diamonds") {
        if (_diamonds >= item["price"]) {
          _diamonds -= item["price"] as int;
          item["isOwned"] = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully purchased ${item["name"]}!"), backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough Diamonds!"), backgroundColor: Colors.red));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedItems = _items.where((item) => item["category"] == _selectedCategory).toList();

    if (displayedItems.isNotEmpty && _selectedIndex >= displayedItems.length) {
      _selectedIndex = 0;
    }

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
            // 🔙 টপ বার
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
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber), const SizedBox(width: 5),
                      Text("$_coins", style: const TextStyle(color: Colors.white, fontSize: 16)), const SizedBox(width: 15),
                      const Icon(Icons.diamond, color: Colors.blueAccent), const SizedBox(width: 5),
                      Text("$_diamonds", style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  )
                ],
              ),
            ),

            // 🔲 মেইন ৩-কলাম লেআউট
            Expanded(
              child: Row(
                children: [
                  // ⬅️ ১. বাম দিক (Left Menu)
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMenuButton("CHARACTER"),
                          _buildMenuButton("FASHION"),
                          _buildMenuButton("COLLECTION"),
                          _buildMenuButton("WEAPON"),
                          _buildMenuButton("PET"),
                        ],
                      ),
                    ),
                  ),

                  // 🔲 ২. মাঝখান (Center Grid)
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: displayedItems.isEmpty 
                      ? const Center(child: Text("Coming Soon...", style: TextStyle(color: Colors.white54, fontSize: 20)))
                      : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8,
                        ),
                        itemCount: displayedItems.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedIndex == index;
                          var item = displayedItems[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                border: Border.all(color: isSelected ? Colors.amber : Colors.transparent, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 🖼️ ক্যারেক্টারের জন্য আসল ফটো, অন্যদের জন্য আইকন
                                  item["category"] == "CHARACTER"
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            item["icon"], 
                                            width: 60, height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red), // ছবি না পেলে এরর দেখাবে
                                          ),
                                        )
                                      : Icon(
                                          item["category"] == "WEAPON" ? Icons.sports_martial_arts : Icons.pets,
                                          size: 50, color: Colors.white54,
                                        ),
                                  const SizedBox(height: 10),
                                  Text(item["name"], style: const TextStyle(color: Colors.white)),
                                  
                                  // দাম বা OWNED দেখানো
                                  item["isOwned"] 
                                  ? const Text("OWNED", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          item["type"] == "diamonds" ? Icons.diamond : Icons.monetization_on,
                                          color: item["type"] == "diamonds" ? Colors.blueAccent : Colors.amber,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text("${item["price"]}", style: const TextStyle(color: Colors.white70)),
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

                  // ➡️ ৩. ডান দিক (Right Preview)
                  Expanded(
                    flex: 4,
                    child: displayedItems.isEmpty 
                    ? const SizedBox()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: ModelViewer(
                            key: ValueKey(displayedItems[_selectedIndex]["model"]), 
                            src: displayedItems[_selectedIndex]["model"],
                            alt: "Store Item",
                            autoRotate: true, cameraControls: true, disableZoom: true, disablePan: true,
                            backgroundColor: Colors.transparent,
                            autoPlay: displayedItems[_selectedIndex]["category"] == "PET",
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // 🛒 PURCHASE / EQUIPPED বাটন
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: displayedItems[_selectedIndex]["isOwned"] ? Colors.green : Colors.amber,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () => _purchaseItem(displayedItems[_selectedIndex]),
                          child: Text(
                            displayedItems[_selectedIndex]["isOwned"] ? "EQUIPPED" : "PURCHASE",
                            style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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

  // মেনু বাটন ফাংশন
  Widget _buildMenuButton(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          _selectedIndex = 0; 
        });
      },
      child: Container(
        width: double.infinity,
        color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.amber : Colors.white,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
