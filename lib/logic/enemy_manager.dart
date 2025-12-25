import 'dart:math';
import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/enemy_model.dart';
import 'package:flutter/material.dart';

typedef EnemyConstructor = Enemy Function();
final Map<String, EnemyConstructor> enemyMap = {
  'first-enemy': () => FirstEnemy(),
};

class EnemyManager extends ChangeNotifier {
  Enemy? currentEnemy;
  EnemyCardManager _cardManager;

  int? get enemyHealth {
    if (currentEnemy == null) return null;
    return currentEnemy!.health;
  }

  int get bonusDamage {
    if (currentEnemy == null) return 0;
    return min(currentEnemy!.health.abs(), 0);
  }

  EnemyManager(this._cardManager);

  void setCurrentEnemy(String enemyId) {
    final constructor = enemyMap[enemyId];
    if (constructor == null) throw Exception('Unknown enemyId: $enemyId');
    currentEnemy = constructor();
    notifyListeners();
    return;
  }

  void takeDamage(int damage) {
    if (currentEnemy == null) return;
    currentEnemy!.health = currentEnemy!.health - damage;
  }

  void updateCardManager(EnemyCardManager newCardManager) {
    _cardManager = newCardManager;
    return;
  }

  Future<void> takeTurn() async {
    print('Enemy taking turn');
    print('Enemy deck has ${_cardManager.deck.length} cards');
    return;
  }
}