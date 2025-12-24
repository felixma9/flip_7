import 'dart:math';
import 'package:flip_7/models/enemy_model.dart';
import 'package:flutter/material.dart';

class EnemyManager extends ChangeNotifier {
  Enemy? currentEnemy;

  int? get enemyHealth {
    if (currentEnemy == null) return null;
    return currentEnemy!.health;
  }

  int get bonusDamage {
    if (currentEnemy == null) return 0;
    return min(currentEnemy!.health.abs(), 0);
  }

  EnemyManager();

  void setCurrentEnemy(String enemyId) {
    currentEnemy = Enemy(enemyId: enemyId);
    notifyListeners();
    return;
  }

  void onAttack(int damage) {
    if (currentEnemy == null) return;
    currentEnemy!.health = currentEnemy!.health - damage;
  }
}