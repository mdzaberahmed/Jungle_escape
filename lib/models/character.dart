class GameCharacter {
  String name;
  int health;
  int energy;
  int attack;
  int defense;
  int coins;
  
  bool isUnlocked; 
  int price; 
  DateTime? lastSkillUsedTime; 
  String currentWeapon; 
  String modelPath; // 3D মডেলের ফাইল লোকেশন 📂

  GameCharacter({
    required this.name,
    required this.health,
    required this.energy,
    required this.attack,
    required this.defense,
    required this.currentWeapon, 
    required this.modelPath,
    this.coins = 0,
    this.isUnlocked = false, 
    this.price = 0, 
  });

  void takeDamage(int damage) {
    int reducedDamage = damage - defense;
    if (reducedDamage < 0) reducedDamage = 0;
    health -= reducedDamage;
    if (health < 0) health = 0;
  }

  void addCoins(int amount) {
    coins += amount;
  }

  bool isAlive() {
    return health > 0;
  }

  bool canUseSkill() {
    if (lastSkillUsedTime == null) return true;
    final now = DateTime.now();
    final difference = now.difference(lastSkillUsedTime!).inSeconds;
    return difference >= 30; 
  }

  void useSkill() {
    if (canUseSkill()) {
      lastSkillUsedTime = DateTime.now(); 
    } 
  }
}