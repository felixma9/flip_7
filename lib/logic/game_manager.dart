import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/logic/enemy_manager.dart';
import 'package:flutter/material.dart';

enum TurnResult {
  continueTurn,
  duplicateDrawn,
  bonusReached,
}

class GameManager extends ChangeNotifier {
  final CardManager _cardManager;
  final EnemyManager _enemyManager;
  int totalPoints = 0;

  static const int bankAttackMultiplier = 2;
  static const int bonusThreshold = 7;
  static const int bonusMultiplier = 3;
  static const int bustAttackAmount = 10;

  GameManager(this._cardManager, this._enemyManager) {
    _enemyManager.setCurrentEnemy('first-enemy');
  }

  TurnResult get turnResult {
    // +1 to account for currentCard
    if (_cardManager.isCurrentCardDuplicate) return TurnResult.duplicateDrawn;
    if (_cardManager.drawnCards.length + 1 == bonusThreshold) return TurnResult.bonusReached;
    return TurnResult.continueTurn;
  }

  void onDrawCard() {
    if (turnResult != TurnResult.continueTurn) {
      onEndTurn();
      return;
    }

    _cardManager.drawCard();
    notifyListeners();
    return;
  }

  void onRestartRound() {
    totalPoints = 0;
    _cardManager.resetDeck();
    _cardManager.discardHand();
    _cardManager.discardCurrent();
    _enemyManager.setCurrentEnemy('first-enemy');
    notifyListeners();
    return;
  }

  void attackFromBank() {
    _enemyManager.onAttack(totalPoints * bankAttackMultiplier);
    totalPoints = 0;
    return;
  }

  void onEndTurn() {
    switch (turnResult) {
      case TurnResult.continueTurn:
        // If player has drawn cards, bank points
        if (_cardManager.drawnCards.isNotEmpty) {
          totalPoints += _cardManager.pointsInHand;
        }

        // Attack from bank if player ended without drawing
        else {
          attackFromBank();
        }
        break;

      case TurnResult.bonusReached:
        // Reaching bonus forces attack
        totalPoints += _cardManager.pointsInHand * bonusMultiplier;
        attackFromBank();
        break;

      case TurnResult.duplicateDrawn:
        // Busting attacks for minimum amount
        _enemyManager.onAttack(bustAttackAmount);
        break;
    }

    _cardManager.discardHand();
    _cardManager.discardCurrent();
    notifyListeners();
    return;
  }
}