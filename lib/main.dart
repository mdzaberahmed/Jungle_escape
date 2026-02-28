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
    // পপ-আপের ভেতরে সিলেক্ট করা ম্যাপ মনে রাখার জন্য
    String tempSelectedMap = _selectedMap; 

    // ৬টি ম্যাপের ডেমো ডাটা (পরবর্তীতে কালারের জায়গায় তুমি ম্যাপের ছবি দিতে পারবে)
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
            width: 700, // পপ-আপের চওড়া সাইজ
            height: 450,
            child: Column(
              children: [
                
                // 🔝 Top Header (সাদা ব্যাকগ্রাউন্ড, ডানদিকে Close আইকন)
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
                            crossAxisCount: 3, // এক লাইনে ৩টি ম্যাপ
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
                                  tempSelectedMap = maps[index]["name"]; // ম্যাপ সিলেক্ট করা
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: maps[index]["color"], // আপাতত কালার দেওয়া হলো
                                  border: Border.all(
                                    color: isSelected ? Colors.yellow : Colors.transparent, // সিলেক্ট হলে হলুদ বর্ডার
                                    width: 3
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  color: Colors.black54, // নামের পেছনে হালকা কালো ব্যাকগ্রাউন্ড
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

                // 🔽 Bottom Footer (CONFIRM Button)
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
                            _selectedMap = tempSelectedMap; // আসল ম্যাপ আপডেট করা
                          });
                          Navigator.pop(context); // ডায়ালগ বন্ধ করা
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

          // 🎨 Cinematic Dark Background
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
                    
                    // 🎥 FINAL AUTO CAMERA: 'auto' নিজে থেকেই ক্যারেক্টারের পারফেক্ট সাইজ বের করে নেবে
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
                  onPressed: () {},
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
