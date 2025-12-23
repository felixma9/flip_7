import 'package:flip_7/logic/card_manager.dart';
import 'package:flutter/material.dart';

enum TurnResult {
  continueTurn,
  duplicateDrawn,
  bonusReached,
}

class GameManager extends ChangeNotifier {
  final CardManager _cardManager;
  int totalPoints = 0;

  int bonusThreshold = 7;
  int bonusMultiplier = 2;

  GameManager(this._cardManager);

  TurnResult get turnResult {
    // +1 to account for currentCard
    if (_cardManager.drawnCards.length + 1 == bonusThreshold) return TurnResult.bonusReached;
    if (_cardManager.isCurrentCardDuplicate) return TurnResult.duplicateDrawn;
    return TurnResult.continueTurn;
  }

  void onDrawCard() {
    if (turnResult != TurnResult.continueTurn) {
      endTurn();
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
    notifyListeners();
    return;
  }

  void endTurn() {
    switch (turnResult) {
      case TurnResult.continueTurn:
        // Player ended turn
        totalPoints += _cardManager.pointsInHand;
        break;

      case TurnResult.bonusReached:
        totalPoints += _cardManager.pointsInHand * bonusMultiplier;
        break;

      case TurnResult.duplicateDrawn:
        break;
    }

    _cardManager.discardHand();
    _cardManager.discardCurrent();
    notifyListeners();
    return;
  }
}