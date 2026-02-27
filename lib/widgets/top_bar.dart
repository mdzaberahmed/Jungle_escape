import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String playerName;
  final int coins;
  final int diamonds;

  const TopBar({
    super.key,
    required this.playerName,
    required this.coins,
    required this.diamonds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(playerName, style: const TextStyle(color: Colors.white)),
          Row(
            children: [
              Text("💰 $coins", style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
              Text("💎 $diamonds", style: const TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}