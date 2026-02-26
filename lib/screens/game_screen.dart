import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart'; // ৩ডি মডেল প্যাকেজ

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🌴 Background - জঙ্গলের থিম 
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              // যদি ইমেজ থাকে তবে এটি ব্যবহার করো:
              // child: Image.asset("assets/bg.jpg", fit: BoxFit.cover),
            ),
          ),

          /// 🔹 Main UI Layout
          Column(
            children: [

              /// 🔝 TOP BAR (প্লেয়ার ইনফো এবং কারেন্সি) 💰
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(child: Icon(Icons.person)),
                        SizedBox(width: 10),
                        Text("SK ROKI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: const [
                        CurrencyIcon(icon: Icons.monetization_on, color: Colors.yellow, value: "5000"),
                        SizedBox(width: 15),
                        CurrencyIcon(icon: Icons.diamond, color: Colors.blue, value: "10"),
                      ],
                    )
                  ],
                ),
              ),

              /// 🔽 BODY (মেনু এবং ক্যারেক্টার)
              Expanded(
                child: Row(
                  children: [

                    /// ⬅️ LEFT MENU (স্টোর, মিশন ইত্যাদি) 🎒
                    Container(
                      width: 150,
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          MenuButton(title: "STORE", icon: Icons.store),
                          MenuButton(title: "MISSIONS", icon: Icons.assignment),
                          MenuButton(title: "EVENTS", icon: Icons.event),
                          MenuButton(title: "VAULT", icon: Icons.inventory_2),
                        ],
                      ),
                    ),

                    /// 👤 CHARACTER AREA (মাঝখানে ৩ডি মডেল) 🏹
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 500, // মডেলের উচ্চতা
                          child: ModelViewer(
                            key: const ValueKey('player_model'), // মডেল রিলোড করার জন্য কী
                            src: 'assets/models/archer.glb', // ৩ডি মডেলের রাস্তা (GLB ফাইল)
                            alt: "Fantasy Archer Character",
                            autoRotate: true, // মডেলটি নিজে থেকেই ঘুরবে
                            autoRotateDelay: 0,
                            cameraControls: true, // প্লেয়ার মডেলটি ঘোরাতে পারবে
                            disableZoom: true, // জুম বন্ধ রাখা হয়েছে লবির জন্য
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    /// ➡️ RIGHT PANEL (সেটিংস, ফ্রেন্ডস) ⚙️
                    Container(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(height: 20),
                          IconButton(onPressed: null, icon: Icon(Icons.settings, color: Colors.white)),
                          IconButton(onPressed: null, icon: Icon(Icons.group, color: Colors.white)),
                          IconButton(onPressed: null, icon: Icon(Icons.mail, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔽 BOTTOM BAR (স্টার্ট বাটন এবং ম্যাপ সিলেক্ট) 🗺️
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.chat, color: Colors.white),
                    
                    /// 🔥 START BUTTON AREA
                    Row(
                      children: [
                        const MapSelector(),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            // গেম শুরু করার লজিক এখানে
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade700,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 10)],
                            ),
                            child: const Text(
                              "START",
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.black),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// কাস্টম উইজেটগুলো নিচে দেওয়া হলো (আগের মতোই আছে):

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class CurrencyIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  const CurrencyIcon({super.key, required this.icon, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 5),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class MapSelector extends StatelessWidget {
  const MapSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Jungle Map", style: TextStyle(color: Colors.amber, fontSize: 12)),
          Text("RANKED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
