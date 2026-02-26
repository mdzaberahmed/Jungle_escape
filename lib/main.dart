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
  int timeLeft = 15;
  bool isPlaying = false;

  double tigerProgress = 0.0;
  int difficultyLevel = 1;

  Timer? gameTimer;
  Timer? tigerTimer;

  void startGame() {
    gameTimer?.cancel();
    tigerTimer?.cancel();

    setState(() {
      score = 0;
      timeLeft = 15;
      tigerProgress = 0.0;
      difficultyLevel = 1;
      isPlaying = true;
    });

    startTimers();
  }

  void startTimers() {
    // Game countdown timer
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          endGame();
        }
      });
    });

    // Tiger progress timer (speeds up based on difficulty)
    tigerTimer = Timer.periodic(
      Duration(milliseconds: 800 - (difficultyLevel * 50)), 
      (timer) {
        if (!mounted || !isPlaying) return;

        setState(() {
          tigerProgress += 0.04 + (difficultyLevel * 0.01);

          if (tigerProgress >= 1) {
            tigerProgress = 1.0;
            endGame();
          }
        });
      },
    );
  }

  void runAction() {
    if (!isPlaying) return;

    setState(() {
      score++;
      tigerProgress -= 0.05;
      if (tigerProgress < 0) tigerProgress = 0;

      // Increase difficulty every 5 points
      if (score % 5 == 0) {
        difficultyLevel++;
        tigerTimer?.cancel();
        startTimers(); // Restart timers with new difficulty speed
      }
    });
  }

  void endGame() {
    gameTimer?.cancel();
    tigerTimer?.cancel();

    if (!mounted) return;

    setState(() {
      isPlaying = false;
      if (score > highScore) {
        highScore = score;
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text("🐯 CAUGHT!", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(timeLeft == 0 ? "Time's up!" : "The tiger caught you!", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 15),
            Text("Final Score: $score", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Level Reached: $difficultyLevel", style: const TextStyle(color: Colors.greenAccent, fontSize: 16)),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
              child: const Text("Play Again", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }

  void resetGame() {
    gameTimer?.cancel();
    tigerTimer?.cancel();

    setState(() {
      score = 0;
      timeLeft = 15;
      tigerProgress = 0.0;
      difficultyLevel = 1;
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    tigerTimer?.cancel();
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TOP SECTION: Stats & Tiger Bar
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🏆 High Score: $highScore", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            "⏳ Time: $timeLeft s", 
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold, 
                              color: timeLeft <= 5 ? Colors.redAccent : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("🐯 Tiger Distance", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: tigerProgress,
                              minHeight: 15,
                              backgroundColor: Colors.white24,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // CENTER SECTION: Score & Level
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
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withAlpha(50),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Level: $difficultyLevel", style: const TextStyle(fontSize: 18, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),

                // BOTTOM SECTION: Controls
                Column(
                  children: [
                    if (!isPlaying)
                      ElevatedButton.icon(
                        onPressed: startGame,
                        icon: const Icon(Icons.play_arrow, size: 30, color: Colors.black),
                        label: const Text("START GAME", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: runAction,
                        child: Container(
                          height: 100,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withAlpha(128), // withOpacity এর পরিবর্তে withAlpha ব্যবহার করা হয়েছে
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                          ),
                          child: const Text(
                            "RUN! 🏃",
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: resetGame,
                      icon: const Icon(Icons.refresh, color: Colors.redAccent),
                      label: const Text("Reset Game", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
