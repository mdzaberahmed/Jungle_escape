import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../widgets/top_bar.dart';
import '../widgets/character_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PlayerModel player = PlayerModel(
    name: "SK ROKI",
    coins: 5000,
    diamonds: 10,
    isBoy: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: [

          TopBar(
            playerName: player.name,
            coins: player.coins,
            diamonds: player.diamonds,
          ),

          Expanded(
            child: Center(
              child: CharacterWidget(isBoy: player.isBoy),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                player.isBoy = !player.isBoy;
              });
            },
            child: const Text("Swap Boy/Girl"),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(200, 50),
            ),
            onPressed: () {},
            child: const Text("START"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}