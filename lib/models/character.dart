class GameCharacter {
  String name;
  int health;
  int energy;
  int attack;
  int defense;
  int coins;

  GameCharacter({
    required this.name,
    required this.health,
    required this.energy,
    required this.attack,
    required this.defense,
    this.coins = 0,
  });

  void takeDamage(int damage) {
    int reducedDamage = damage - defense;
    if (reducedDamage < 0) reducedDamage = 0;

    health -= reducedDamage;

    if (health < 0) {
      health = 0;
    }
  }

  void useEnergy(int amount) {
    energy -= amount;
    if (energy < 0) {
      energy = 0;
    }
  }

  void addCoins(int amount) {
    coins += amount;
  }

  bool isAlive() {
    return health > 0;
  }
}