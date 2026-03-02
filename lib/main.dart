kimport 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

// এখান থেকে তোমার অন্যান্য স্ক্রিন ইম্পোর্ট করতে হবে (যেমন: store_screen.dart, game_screen.dart)

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
  String _selectedMap = "Neon Nexus"; // ডিফল্ট ম্যাপ

  @override
  void initState() {
    super.initState();
    // এই কন্ট্রোলারটি পাখির অ্যানিমেশনের জন্য
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center, // 👈 ছবি এবং মডেলকে প্ল্যাটফর্মের উপর ঠিকভাবে বসানোর জন্য
        children: [
          // ১. ব্যাকগ্রাউন্ড ইমেজ (তোমার আপলোড করা ছবিটি!) 🗺️
          Positioned.fill(
            child: Image.asset(
              'assets/images/lobby_bg.png', // 👈 ছবির পাথ আপডেট করা হয়েছে
              fit: BoxFit.cover, // ছবিটি যেন পুরো স্ক্রিন জুড়ে থাকে
            ),
          ),

          // ২. মেইন ক্যারেক্টার 👤 (প্ল্যাটফর্মের উপর স্থাপন করা হয়েছে)
          const SizedBox(
            width: 500, height: 500,
            child: Transform.translate(
              offset: Offset(0, 180), // 👈 ক্যারেক্টারটিকে গোল প্ল্যাটফর্মের উপর নামানো হয়েছে
              child: ModelViewer(
                src: 'assets/models/player.glb', 
                alt: "Player Character",
                autoRotate: false, cameraControls: true, disableZoom: true, disablePan: true,
                cameraOrbit: "0deg 85deg 25m", minCameraOrbit: "-140deg 75deg 25m", maxCameraOrbit: "140deg 95deg 25m",
                fieldOfView: "45deg", exposure: 1.1, shadowIntensity: 1, backgroundColor: Colors.transparent,
              ),
            ),
          ),

          // ৩. উড়ন্ত ফিনিক্স পাখি 🦅 (ক্যারেক্টারের একটু উপরে ঘোরানোর জন্য Offset ঠিক করা হয়েছে)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double angle = _controller.value * 2 * pi;
              // X এবং Y অক্ষে বৃত্তাকারে ঘোরার লজিক
              double dx = cos(angle) * 180; 
              double dy = sin(angle) * 40;  

              return Transform.translate(
                offset: Offset(dx, dy + 150), // 👈 পাখির পজিশন প্ল্যাটফর্ম এবং ক্যারেক্টারের সাথে ঠিক করা হয়েছে
                child: SizedBox(
                  width: 150, height: 150,
                  child: IgnorePointer( // পাখি যেন ক্যারেক্টার ঘোরানোতে বাধা না দেয়
                    child: ModelViewer(
                      src: 'assets/models/phoenix_bird.glb',
                      autoRotate: true, cameraControls: false, disableZoom: true, disablePan: true,
                      backgroundColor: Colors.transparent,
                      autoPlay: true, // পাখির ডানা ঝাপটানোর অ্যানিমেশন চালু
                    ),
                  ),
                ),
              );
            },
          ),
          
          // ৪. এনার্জি অরা পালস ইফেক্ট (ঐচ্ছিক, একটু গ্লো যোগ করার জন্য) ✨
          Positioned(
            bottom: 60, // প্ল্যাটফর্মের উপর স্থাপন
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // পালস ইফেক্ট
                  double pulse = 1.0 + sin(_controller.value * 4 * pi) * 0.05;
                  return Transform.scale(
                    scale: pulse,
                    child: child,
                  );
                },
                child: Container(
                  width: 380, height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 40, spreadRadius: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- UI Overlays (Top, Left, Right) ---
          // ... তোমার আগের ইউআই এলিমেন্টগুলো (প্রোফাইল, কয়েন, মেনু, স্টার্ট বাটন) এখানে আসবে।
          // আমি কোড কমানোর জন্য এই অংশগুলো লিখিনি, তবে তুমি আগের main.dart থেকে সেগুলো এই Stack এর নিচে যোগ করে দেবে।
          
        ],
      ),
    );
  }
}
