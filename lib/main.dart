import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f2027), Color(0xff203a43)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [

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
                      CircleAvatar(radius: 25),
                      SizedBox(width: 10),
                      Text("SK ROKI",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.monetization_on,
                          color: Colors.amber),
                      SizedBox(width: 5),
                      Text("5000",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.diamond,
                          color: Colors.blueAccent),
                      SizedBox(width: 5),
                      Text("10",
                          style: TextStyle(color: Colors.white)),
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

            /// 🔥 CENTER CHARACTER
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: child,
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
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
                    Image.network(
                      "https://i.imgur.com/8Km9tLL.png",
                      height: 300,
                    ),
                  ],
                ),
              ),
            ),

            /// 🔥 RIGHT SIDE
            Positioned(
              right: 20,
              top: 150,
              child: Column(
                children: const [
                  Icon(Icons.swap_horiz,
                      color: Colors.white, size: 30),
                  SizedBox(height: 20),
                  Icon(Icons.settings,
                      color: Colors.white, size: 30),
                  SizedBox(height: 20),
                  Icon(Icons.group,
                      color: Colors.white, size: 30),
                  SizedBox(height: 20),
                  Icon(Icons.mail,
                      color: Colors.white, size: 30),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Map: Bermuda",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "START",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
