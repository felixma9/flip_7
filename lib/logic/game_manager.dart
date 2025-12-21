import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flutter/material.dart';

class GameManager extends ChangeNotifier {
  final CardManager _cardManager;
  
  int totalPoints = 0;
  int accumulatedPoints = 0;

  GameManager(this._cardManager);

  void drawCard() {
    PlayingCard? drawnCard = _cardManager.currentCard;
    if (drawnCard != null) {
      // If this card is a duplicate, end the turn
      if (_cardManager.isCurrentCardDuplicate) {
        _cardManager.discardCurrent();
        endTurn();
      } else {
        // If unique, add to accumulated points, card to drawn cards
        _cardManager.addCurrentCardToHand();
        accumulatedPoints += drawnCard.value;
      }
    }

    _cardManager.drawCard();
    notifyListeners();
  }

  void endTurn() {
    totalPoints += accumulatedPoints;
    accumulatedPoints = 0;
    _cardManager.discardHand();
  }
}