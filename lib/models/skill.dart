class Skill {
  String name;
  int level;
  int maxLevel;
  int cost;

  Skill({
    required this.name,
    this.level = 1,
    this.maxLevel = 3,
    required this.cost,
  });

  void upgrade() {
    if (level < maxLevel) level++;
  }

  int getUpgradeCost() {
    return cost * level;
  }

  bool isMaxLevel() {
    return level >= maxLevel;
  }
}