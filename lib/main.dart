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
  
  // 👈 বর্তমান সিলেক্ট করা ম্যাপের নাম রাখার জন্য ভেরিয়েবল
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

  // 🗺️ ম্যাপ নির্বাচনের পপ-আপ ডায়ালগ ফাংশন
  void _showMapSelectionDialog() {
    List<String> mapList = ["Neon Nexus", "Crimson Sands", "Frostbite Ridge"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff0f2027),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "SELECT MAP",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mapList.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedMap == mapList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.orange.withOpacity(0.2) : Colors.white12,
                    border: Border.all(color: isSelected ? Colors.orange : Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(mapList[index], style: const TextStyle(color: Colors.white, fontSize: 18)),
                    trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.orange) : null,
                    onTap: () {
                      setState(() {
                        _selectedMap = mapList[index]; // 👈 নতুন ম্যাপ সিলেক্ট করা
                      });
                      Navigator.pop(context); // ডায়ালগ বন্ধ করা
                    },
                  ),
                );
              },
            ),
          ),
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
                colors: [
                  Color(0xFF14002B),
                  Color(0xFF000000),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🔥 CENTER CHARACTER (3D Model + Glowing Background)
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
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.7),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(
                  width: 600,
                  height: 600,
                  child: ModelViewer(
                    src: 'assets/models/player.glb', 
                    alt: "Player Character",
                    autoRotate: false,
                    cameraControls: true,
                    disableZoom: true,
                    disablePan: true,
                    
                    cameraOrbit: "0deg 76deg 9m",
                    minCameraOrbit: "-140deg 72deg 9m",
                    maxCameraOrbit: "140deg 85deg 9m",
                    fieldOfView: "24deg",
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
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(radius: 25, child: Icon(Icons.person)),
                    SizedBox(width: 10),
                    Text("SK_ROKI", 
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.monetization_on, color: Colors.amber),
                    SizedBox(width: 5),
                    Text("5000", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 20),
                    Icon(Icons.diamond, color: Colors.blueAccent),
                    SizedBox(width: 5),
                    Text("10", style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),

          /// 🔥 LEFT MENU
          Positioned(
            left: 20,
            top: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MenuItem(title: "STORE"),
                MenuItem(title: "MISSIONS"),
                MenuItem(title: "EVENTS"),
                MenuItem(title: "VAULT"),
              ],
            ),
          ),

          /// 🔥 RIGHT SIDE
          Positioned(
            right: 20,
            top: 150,
            child: Column(
              children: const [
                Icon(Icons.swap_horiz, color: Colors.white, size: 30),
                SizedBox(height: 20),
                Icon(Icons.settings, color: Colors.white, size: 30),
                SizedBox(height: 20),
                Icon(Icons.group, color: Colors.white, size: 30),
                SizedBox(height: 20),
                Icon(Icons.mail, color: Colors.white, size: 30),
              ],
            ),
          ),

          /// 🔥 MAP + START BUTTON
          Positioned(
            right: 40,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 👈 ক্লিকেবল ম্যাপ বাটন
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), 
                    ),
                    elevation: 12, 
                  ),
                  onPressed: () {},
                  child: const Text(
                    "START",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2), 
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
        style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

