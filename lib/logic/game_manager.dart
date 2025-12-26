import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/logic/enemy_manager.dart';
import 'package:flutter/material.dart';

enum TurnState {
  player,
  enemy,
  resolving,
  gameOver,
}

enum TurnResult {
  continueTurn,
  duplicateDrawn,
  bonusReached,
}

class GameManager extends ChangeNotifier {
  final CardManager  _cardManager;
  final EnemyManager _enemyManager;
  int totalPoints = 0;
  TurnState turnState = TurnState.player;

  static const double bankAttackMultiplier = 1.0;
  static const int bonusThreshold   = 7;
  static const int bonusMultiplier  = 2;
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

  bool get isPlayerTurn => turnState == TurnState.player;
  bool get isEnemyTurn  => turnState == TurnState.enemy;
  bool get isResolving  => turnState == TurnState.resolving;
  bool get isGameOver   => turnState == TurnState.gameOver;

  void onDrawCard() {
    if (!isPlayerTurn) return;

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
    _enemyManager.takeDamage((totalPoints * bankAttackMultiplier).ceil());
    totalPoints = 0;
    return;
  }

  void onEndTurn() {
    if (!isPlayerTurn) return;

    switch (turnResult) {
      case TurnResult.continueTurn:
        // If player has drawn cards, bank points
        if (_cardManager.drawnCards.isNotEmpty || 
            _cardManager.currentCard != null) {
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
        _enemyManager.takeDamage(bustAttackAmount);
        break;
    }

    _cardManager.discardHand();
    _cardManager.discardCurrent();
    turnState = TurnState.enemy;
    notifyListeners();

    startEnemyTurn();
    return;
  }

  Future<void> startEnemyTurn() async {
    if (turnState != TurnState.enemy) return;

    _enemyManager.resetHand();
    
    await _enemyManager.takeTurn();

    print('Enemy ended turn with ${_enemyManager.pointsInHand} points');

    turnState = TurnState.player;
    print("player's turn");
    notifyListeners();
    return;
  }
}