import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // 📦 স্টোরের সব আইটেমের লিস্ট
  final List<Map<String, dynamic>> _items = [
    {"name": "Gojo Style", "model": "assets/models/player.glb", "price": "Owned", "type": "coins"},
    {"name": "Warrior Alpha", "model": "assets/models/char1.glb", "price": "2000", "type": "coins"},
    {"name": "Cyber Ninja", "model": "assets/models/char2.glb", "price": "50", "type": "diamonds"},
    {"name": "Shadow Hunter", "model": "assets/models/char3.glb", "price": "100", "type": "diamonds"},
    {"name": "Katana Blade", "model": "assets/models/sword.glb", "price": "300", "type": "diamonds"},
    {"name": "Fire Phoenix", "model": "assets/models/phoenix_bird.glb", "price": "500", "type": "diamonds"}, // 👈 নাম আপডেট করা হয়েছে
  ];

  int _selectedIndex = 0; 

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
            Expanded(
              child: Row(
                children: [
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
                          _buildMenuButton("PET", false),
                        ],
                      ),
                    ),
                  ),
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
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
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
                                  Icon(
                                    _items[index]["name"].contains("Katana") 
                                        ? Icons.sports_martial_arts 
                                        : _items[index]["name"].contains("Phoenix") 
                                            ? Icons.pets 
                                            : Icons.person, 
                                    size: 50, 
                                    color: Colors.white54
                                  ), 
                                  const SizedBox(height: 10),
                                  Text(_items[index]["name"], style: const TextStyle(color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _items[index]["type"] == "diamonds" ? Icons.diamond : Icons.monetization_on,
                                        color: _items[index]["type"] == "diamonds" ? Colors.blueAccent : Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(_items[index]["price"], style: const TextStyle(color: Colors.white70)),
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
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: ModelViewer(
                            key: ValueKey(_items[_selectedIndex]["model"]), 
                            src: _items[_selectedIndex]["model"],
                            alt: "Store Item",
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
                          onPressed: () {},
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
