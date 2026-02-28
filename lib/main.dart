import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LobbyScreen(),
    );
  }
}

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  
  String _selectedMap = "Neon Nexus"; 

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🗺️ Premium Grid Map Selection Dialog
  void _showMapSelectionDialog() {
    String tempSelectedMap = _selectedMap; 

    List<Map<String, dynamic>> maps = [
      {"name": "Neon Nexus", "color": Colors.blueGrey},
      {"name": "Crimson Sands", "color": Colors.brown},
      {"name": "Frostbite Ridge", "color": Colors.lightBlue},
      {"name": "Solaris", "color": Colors.orangeAccent},
      {"name": "Titan Outpost", "color": Colors.deepPurple},
      {"name": "Apex City", "color": Colors.teal},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 700, 
            height: 450,
            child: Column(
              children: [
                
                // 🔝 Top Header 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SELECT MAP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      InkWell(
                        onTap: () => Navigator.pop(context), 
                        child: const Icon(Icons.close, color: Colors.black, size: 28)
                      )
                    ],
                  )
                ),

                // 🖼️ Grid Map List
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setDialogState) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, 
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 16 / 9,
                          ),
                          itemCount: maps.length,
                          itemBuilder: (context, index) {
                            bool isSelected = tempSelectedMap == maps[index]["name"];
                            
                            return GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  tempSelectedMap = maps[index]["name"]; 
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: maps[index]["color"], 
                                  border: Border.all(
                                    color: isSelected ? Colors.yellow : Colors.transparent, 
                                    width: 3
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  color: Colors.black54, 
                                  child: Text(
                                    maps[index]["name"], 
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              )
                            );
                          }
                        )
                      );
                    }
                  )
                ),

                // 🔽 Bottom Footer 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedMap = tempSelectedMap; 
                          });
                          Navigator.pop(context); 
                        },
                        child: const Text("CONFIRM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                      )
                    ]
                  )
                )

              ]
            )
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // 🎨 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF14002B), Color(0xFF000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🔥 CENTER CHARACTER
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 350, height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.orange.withOpacity(0.7), blurRadius: 40, spreadRadius: 10)
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(
                  width: 600, height: 600,
                  child: ModelViewer(
                    src: 'assets/models/player.glb', 
                    alt: "Player Character",
                    autoRotate: false,
                    cameraControls: true,
                    disableZoom: true,
                    disablePan: true,
                    cameraOrbit: "0deg 75deg auto", 
                    fieldOfView: "45deg", 
                    exposure: 1.1,
                    shadowIntensity: 1,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 TOP BAR
          Positioned(
            top: 20, left: 20, right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(radius: 25, child: Icon(Icons.person)), SizedBox(width: 10),
                    Text("SK_ROKI", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.monetization_on, color: Colors.amber), SizedBox(width: 5),
                    Text("5000", style: TextStyle(color: Colors.white)), SizedBox(width: 20),
                    Icon(Icons.diamond, color: Colors.blueAccent), SizedBox(width: 5),
                    Text("10", style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),

          /// 🔥 LEFT MENU
          Positioned(
            left: 20, top: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MenuItem(title: "STORE"), MenuItem(title: "MISSIONS"),
                MenuItem(title: "EVENTS"), MenuItem(title: "VAULT"),
              ],
            ),
          ),

          /// 🔥 RIGHT SIDE
          Positioned(
            right: 20, top: 150,
            child: Column(
              children: const [
                Icon(Icons.swap_horiz, color: Colors.white, size: 30), SizedBox(height: 20),
                Icon(Icons.settings, color: Colors.white, size: 30), SizedBox(height: 20),
                Icon(Icons.group, color: Colors.white, size: 30), SizedBox(height: 20),
                Icon(Icons.mail, color: Colors.white, size: 30),
              ],
            ),
          ),

          /// 🔥 MAP + START BUTTON
          Positioned(
            right: 40, bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _showMapSelectionDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white54, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Map: $_selectedMap", style: const TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    elevation: 12, 
                  ),
                  onPressed: () {
                    // 👈 এখানে নতুন স্ক্রিনে যাওয়ার কোড যোগ করা হয়েছে
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(mapName: _selectedMap),
                      ),
                    );
                  },
                  child: const Text(
                    "START",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2), 
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  const MenuItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// 🎮 নতুন গেম স্ক্রিন (যেখানে ম্যাপ লোড হবে)
class GameScreen extends StatelessWidget {
  final String mapName; // কোন ম্যাপ সিলেক্ট হয়েছে তা মনে রাখার জন্য

  const GameScreen({super.key, required this.mapName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // আপাতত একটি ব্যাকগ্রাউন্ড কালার
      body: Stack(
        children: [
          // স্ক্রিনের মাঝখানে ম্যাপের নাম দেখাবে
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map, size: 80, color: Colors.orange),
                const SizedBox(height: 20),
                Text(
                  "LOADING MAP:\n$mapName",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // লবিতে ফিরে যাওয়ার জন্য একটি ব্যাক বাটন
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // 👈 এটি চাপলে আবার লবিতে ফিরে যাবে
              },
            ),
          ),
        ],
      ),
    );
  }
}
