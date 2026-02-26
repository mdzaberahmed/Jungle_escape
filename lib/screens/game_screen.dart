import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [

          /// 🌴 Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0f2027),
                    Color(0xFF203a43),
                    Color(0xFF2c5364)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Column(
            children: [

              /// 🔝 TOP BAR
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              AssetImage("assets/images/player_avatar.png"),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "SK ROKI",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        CurrencyIcon(
                            icon: Icons.monetization_on,
                            color: Colors.yellow,
                            value: "5000"),
                        SizedBox(width: 15),
                        CurrencyIcon(
                            icon: Icons.diamond,
                            color: Colors.blue,
                            value: "10"),
                      ],
                    )
                  ],
                ),
              ),

              /// 🔽 BODY
              Expanded(
                child: Row(
                  children: [

                    /// ⬅️ LEFT MENU
                    Container(
                      width: 160,
                      padding: const EdgeInsets.only(left: 15),
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

                    /// 👤 CHARACTER AREA
                    Expanded(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            /// 🔥 Glow Effect
                            Container(
                              height: screenHeight * 0.45,
                              width: screenHeight * 0.45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.6),
                                    blurRadius: 60,
                                    spreadRadius: 20,
                                  )
                                ],
                              ),
                            ),

                            /// 🏹 3D Model
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ModelViewer(
                                key: const ValueKey('player_model'),
                                src: 'assets/models/archer.glb',
                                alt: "Fantasy Archer Girl",
                                autoRotate: true,
                                autoRotateDelay: 0,
                                cameraControls: true,
                                disableZoom: true,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// ➡️ RIGHT PANEL
                    Container(
                      width: 70,
                      child: Column(
                        children: const [
                          SizedBox(height: 20),
                          IconButton(
                              onPressed: null,
                              icon:
                                  Icon(Icons.settings, color: Colors.white)),
                          IconButton(
                              onPressed: null,
                              icon: Icon(Icons.group, color: Colors.white)),
                          IconButton(
                              onPressed: null,
                              icon: Icon(Icons.mail, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔽 BOTTOM BAR
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.chat, color: Colors.white),

                    Row(
                      children: [
                        const MapSelector(),
                        const SizedBox(width: 25),

                        /// 🔥 Animated START Button
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.95, end: 1),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          builder: (context, double scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              // Start Game Logic
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 18),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade600,
                                    Colors.red.shade600
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.orange.withOpacity(0.6),
                                      blurRadius: 15)
                                ],
                              ),
                              child: const Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
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
