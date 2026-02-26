import '../models/character.dart';
import '../models/skill.dart';

class GameManager {
  late GameCharacter player;
  late Skill attackSkill;
  late Skill defenseSkill;

  List<GameCharacter> characterLibrary = [
    GameCharacter(
      name: "Archer", health: 100, energy: 100, attack: 20, defense: 5,
      currentWeapon: "তীর-ধনুক", modelPath: "assets/models/archer.glb", isUnlocked: true, price: 0,
    ),
    GameCharacter(
      name: "sk roki", health: 85, energy: 150, attack: 35, defense: 2,
      currentWeapon: "কাতানা", modelPath: "assets/models/ninja.glb", isUnlocked: false, price: 10000,
    ),
    GameCharacter(
      name: "Shooter", health: 90, energy: 100, attack: 30, defense: 4,
      currentWeapon: "বন্দুক", modelPath: "assets/models/shooter.glb", isUnlocked: false, price: 10000,
    ),
    GameCharacter(
      name: "Warrior", health: 110, energy: 90, attack: 25, defense: 6,
      currentWeapon: "চাকু", modelPath: "assets/models/warrior.glb", isUnlocked: false, price: 10000,
    ),
    GameCharacter(
      name: "Tank", health: 150, energy: 80, attack: 15, defense: 10,
      currentWeapon: "কুঠার", modelPath: "assets/models/tank.glb", isUnlocked: false, price: 10000,
    ),
  ];

  void startGame() {
    player = characterLibrary[0]; // শুরুতে ফ্রি আর্চার সিলেক্ট থাকবে
    attackSkill = Skill(name: "Attack Boost", cost: 20);
    defenseSkill = Skill(name: "Defense Boost", cost: 15);
  }

  void tigerAttack() { player.takeDamage(25); }
  void earnCoins(int amount) { player.addCoins(amount); }

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

  bool isGameOver() { return !player.isAlive(); }
}