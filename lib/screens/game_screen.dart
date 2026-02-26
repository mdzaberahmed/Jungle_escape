import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isBoy = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [

          /// Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0f2027),
                    Color(0xFF203a43),
                    Color(0xFF2c5364),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Column(
            children: [

              /// ================= TOP BAR =================
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// Player Info
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

                    /// Currency
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

              /// ================= BODY =================
              Expanded(
                child: Row(
                  children: [

                    /// LEFT MENU
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

                    /// CHARACTER AREA
                    Expanded(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            /// Glow Effect
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

                            /// 3D Model
                            SizedBox(
                              height: screenHeight * 0.65,
                              child: ModelViewer(
                                key: ValueKey(isBoy),
                                src: isBoy
                                    ? 'assets/models/archer_boy.glb'
                                    : 'assets/models/archer_girl.glb',
                                alt: "Fantasy Archer",
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

                    /// RIGHT PANEL
                    Container(
                      width: 80,
                      child: Column(
                        children: [

                          const SizedBox(height: 20),

                          IconButton(
                            onPressed: () {
                              setState(() {
                                isBoy = !isBoy;
                              });
                            },
                            icon: const Icon(Icons.swap_horiz,
                                color: Colors.white),
                          ),

                          const SizedBox(height: 10),
                          const Icon(Icons.settings, color: Colors.white),
                          const SizedBox(height: 10),
                          const Icon(Icons.group, color: Colors.white),
                          const SizedBox(height: 10),
                          const Icon(Icons.mail, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ================= BOTTOM BAR =================
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

                        GestureDetector(
                          onTap: () {},
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
                                  blurRadius: 15,
                                )
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

/// ================= CUSTOM WIDGETS =================

class CurrencyIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;

  const CurrencyIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
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
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        "Bermuda",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
