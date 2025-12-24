Map<String, ({int health})> enemyDefinitions = {
  'first-enemy': (health: 100),
};

class Enemy {
  int health;

  Enemy({
    required String enemyId,
  }) : health = (() {
    final enemy = enemyDefinitions[enemyId];
    if (enemy == null) throw ArgumentError('Invalid enemyId: $enemyId');
    return enemy.health;
  })();
}