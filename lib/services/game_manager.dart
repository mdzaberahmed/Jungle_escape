import '../models/character.dart';
import '../models/skill.dart';

class GameManager {
  late GameCharacter player;
  late Skill attackSkill;
  late Skill defenseSkill;

  void startGame() {
    player = GameCharacter(
      name: "Warrior",
      health: 100,
      energy: 100,
      attack: 20,
      defense: 5,
    );

    attackSkill = Skill(name: "Attack Boost", cost: 20);
    defenseSkill = Skill(name: "Defense Boost", cost: 15);
  }

  void tigerAttack() {
    player.takeDamage(25);
  }

  void earnCoins(int amount) {
    player.addCoins(amount);
  }

  void upgradeAttackSkill() {
    int cost = attackSkill.getUpgradeCost();

    if (player.coins >= cost && !attackSkill.isMaxLevel()) {
      player.coins -= cost;
      attackSkill.upgrade();
      player.attack += 5;
    }
  }

  void upgradeDefenseSkill() {
    int cost = defenseSkill.getUpgradeCost();

    if (player.coins >= cost && !defenseSkill.isMaxLevel()) {
      player.coins -= cost;
      defenseSkill.upgrade();
      player.defense += 3;
    }
  }

  bool isGameOver() {
    return !player.isAlive();
  }
}