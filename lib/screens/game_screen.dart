import 'package:flutter/material.dart';
import '../services/game_manager.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameManager gameManager = GameManager();

  @override
  void initState() {
    super.initState();
    gameManager.startGame();
  }

  @override
  Widget build(BuildContext context) {
    var player = gameManager.player;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jungle Survival"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${player.name}"),
            Text("Health: ${player.health}"),
            Text("Energy: ${player.energy}"),
            Text("Attack: ${player.attack}"),
            Text("Defense: ${player.defense}"),
            Text("Coins: ${player.coins}"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameManager.tigerAttack();
                });
              },
              child: const Text("Tiger Attack 🐅"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameManager.earnCoins(20);
                });
              },
              child: const Text("Earn 20 Coins 💰"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameManager.upgradeAttackSkill();
                });
              },
              child: const Text("Upgrade Attack ⚔"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameManager.upgradeDefenseSkill();
                });
              },
              child: const Text("Upgrade Defense 🛡"),
            ),

            const SizedBox(height: 20),

            if (gameManager.isGameOver())
              const Text(
                "GAME OVER ☠",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}