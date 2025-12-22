import 'package:flip_7/logic/card_manager.dart';
import 'package:flutter/material.dart';

class GameManager extends ChangeNotifier {
  final CardManager _cardManager;
  int totalPoints = 0;

  GameManager(this._cardManager);

  void drawCard() {
    if (_cardManager.isCurrentCardDuplicate) endTurn();
    _cardManager.drawCard();
    notifyListeners();
    return;
  }

  void endTurn() {
    if (!_cardManager.isCurrentCardDuplicate) totalPoints += _cardManager.pointsInHand;
    
    _cardManager.discardHand();
    _cardManager.discardCurrent();
    notifyListeners();
    return;
  }
}