import 'package:flutter/material.dart';

// 🎮 প্রফেশনাল গেম স্ক্রিন (লোডিং অ্যানিমেশন সহ)
class GameScreen extends StatefulWidget {
  final String mapName;
  const GameScreen({super.key, required this.mapName});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double _loadingProgress = 0.0;
  bool _isLoaded = false;
  String _currentTip = "Tip: Find a safe zone before engaging enemies!";

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  // ⏳ রিয়েল-টাইম লোডিং ফাংশন
  void _startLoading() async {
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(const Duration(milliseconds: 60)); // লোডিংয়ের স্পিড
      if (mounted) {
        setState(() {
          _loadingProgress = i / 100;
          
          // ৫০% লোডিং হলে টিপস পরিবর্তন হবে
          if (i == 50) {
            _currentTip = "Tip: Keep an eye on the mini-map to spot danger.";
          }
        });
      }
    }
    // ১০০% হয়ে গেলে ম্যাপ লোড হবে
    if (mounted) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🎨 ব্যাকগ্রাউন্ড (লোডিং চলাকালীন এবং লোড হওয়ার পর)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isLoaded 
                  ? [const Color(0xFF1E3C72), const Color(0xFF2A5298)] 
                  : [const Color(0xFF0F2027), const Color(0xFF203A43)], 
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🗺️ এখানে পরবর্তীতে থ্রিডি ম্যাপ বসবে
          if (_isLoaded)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.public, color: Colors.greenAccent, size: 80),
                  const SizedBox(height: 20),
                  Text(
                    "${widget.mapName} LOADED SUCCESSFULLY",
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("3D Map Model will be placed here", style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),

          // ⏳ লোডিং ইউজার ইন্টারফেস (UI)
          if (!_isLoaded)
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "LOADING: ${widget.mapName.toUpperCase()}...",
                        style: const TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      Text(
                        "${(_loadingProgress * 100).toInt()}%",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  // প্রোগ্রেস বার
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _loadingProgress,
                      minHeight: 12,
                      backgroundColor: Colors.white24,
                      color: Colors.orange,
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  // গেমপ্লে টিপস
                  Text(
                    _currentTip,
                    style: const TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

          // 🔙 লবিতে ফিরে যাওয়ার বাটন
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
          ),
        ],
      ),
    );
  }
}
