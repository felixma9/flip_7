import 'dart:math';
import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/enemy_model.dart';
import 'package:flutter/material.dart';

typedef EnemyConstructor = Enemy Function();

final Map<String, EnemyConstructor> enemyMap = {
  'first-enemy': () => FirstEnemy(),
};

class EnemyManager extends ChangeNotifier {
  // Invariant: so long as currentEnemy is defined, all other optional
  // fields should also be defined
  Enemy? currentEnemy;
  int? health;
  EnemyCardManager _cardManager;

  static const int bonusThreshold = 7;

  int get bonusDamage => currentEnemy == null ? 0 : min(health!.abs(), 0);

  int get pointsInHand {
    if (currentEnemy == null) return 0;
    return _cardManager.pointsInHand;
  }

  bool get bust {
    return _cardManager.isCurrentCardDuplicate;
  }

  EnemyManager(this._cardManager);

  void setCurrentEnemy(String enemyId) {
    final constructor = enemyMap[enemyId];
    if (constructor == null) throw Exception('Unknown enemyId: $enemyId');

    currentEnemy = constructor();
    health = currentEnemy!.startingHealth;

    notifyListeners();
    return;
  }

  void takeDamage(int damage) {
    if (currentEnemy == null) return;
    health = health! - damage;
  }

  void updateCardManager(EnemyCardManager newCardManager) {
    _cardManager = newCardManager;
    return;
  }

  void drawCard() {
    _cardManager.drawCard();
  }

  void resetHand() {
    _cardManager.discardHand();
    _cardManager.discardCurrent();
  }

  Future<void> takeTurn() async {
    if (currentEnemy == null) return;
    
    // Enemy draws a random number of cards each turn
    Random random = Random();
    final int numCardsToDraw = random.nextInt(bonusThreshold + 1);

    print('Enemy is going to draw $numCardsToDraw cards');

    for (int i = 0; i < numCardsToDraw; ++i) {
      print('enemy drawing card');
      print('enemy deck has ${_cardManager.deck.length} cards left');
      await Future.delayed(Duration(seconds: 2));
      if (bust) break;
      drawCard();
    }

    notifyListeners();
    return;
  }
}