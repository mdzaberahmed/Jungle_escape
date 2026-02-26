import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const JungleEscapeApp());
}

class JungleEscapeApp extends StatelessWidget {
  const JungleEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jungle Escape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int score = 0;
  int highScore = 0;
  int timeLeft = 10; // 10 seconds to escape
  bool isPlaying = false;
  Timer? timer;

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 10;
      isPlaying = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          endGame();
        }
      });
    });
  }

  void runAction() {
    if (isPlaying) {
      setState(() {
        score++;
      });
    }
  }

  void endGame() {
    timer?.cancel();
    setState(() {
      isPlaying = false;
      if (score > highScore) {
        highScore = score;
      }
    });
    
    // Game Over Alert Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(child: Text("🛑 Game Over!")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("The tiger almost caught you!", textAlign: TextAlign.center),
            const SizedBox(height: 15),
            Text("Steps Taken: $score", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Try Again", style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }

  void resetGame() {
    timer?.cancel();
    setState(() {
      score = 0;
      timeLeft = 10;
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade900,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Bar: High Score & Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "🏆 High Score: $highScore",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: timeLeft <= 3 ? Colors.red.withOpacity(0.8) : Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "⏳ Time: $timeLeft s",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                // Center: Current Score
                Column(
                  children: [
                    const Text(
                      "🌴 JUNGLE ESCAPE",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "$score",
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 10.0, color: Colors.greenAccent, offset: Offset(0, 0)),
                        ],
                      ),
                    ),
                    const Text(
                      "Steps",
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ],
                ),

                // Bottom: Action Buttons
                Column(
                  children: [
                    if (!isPlaying)
                      ElevatedButton.icon(
                        onPressed: startGame,
                        icon: const Icon(Icons.play_arrow, size: 30, color: Colors.black),
                        label: const Text("START ESCAPE", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      )
                    else
                      InkWell(
                        onTap: runAction,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 100,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                          ),
                          child: const Text(
                            "RUN! 🏃‍♂️",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: resetGame,
                      icon: const Icon(Icons.refresh, color: Colors.redAccent),
                      label: const Text("Reset Game", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
