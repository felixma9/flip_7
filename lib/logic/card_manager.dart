// This manager is a singleton, and represents the 
// GROUND TRUTH for the remaining cards in the deck
import 'package:flip_7/models/card_model.dart';
import 'package:flutter/foundation.dart';

const Map<int, int> deckDefinition = {
  0: 1,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
  10: 10,
  11: 11,
  12: 12,
};

class CardManager extends ChangeNotifier {
  late final List<PlayingCard> deck;
  List<PlayingCard> drawnCards = [];
  List<PlayingCard> discardPile = [];

  int get pointsInHand {
    int points = 0;
    for (PlayingCard card in drawnCards) {
      points += card.value;
    }
    return points;
  }
  
  PlayingCard? currentCard;

  bool get isCurrentCardDuplicate {
    if (currentCard == null) return false;
    return drawnCards.any((card) => card.value == currentCard!.value);
  }

  CardManager() {
    resetDeck();
  }

  void resetDeck() {
    deck = deckDefinition.entries.expand<PlayingCard>((entry) {
      final value = entry.key;
      final count = entry.value;
      return List.generate(count, (_) => PlayingCard(value: value));
    }).toList();

    discardPile = [];

    deck.shuffle();
  }

  // Invariant: after drawing, currentCard should NOT be null
  void drawCard() {
    if (deck.isEmpty) return;

    // If a card was previously drawn, add that card to hand first
    if (currentCard != null) drawnCards = [...drawnCards, currentCard!];

    currentCard = deck.removeLast();
    notifyListeners();
    return;
  }

  void addCurrentCardToHand() {
    if (currentCard == null) return;

    drawnCards = [...drawnCards, currentCard!];
    notifyListeners();
    return;
  }

  void discardCurrent() {
    if (currentCard == null) return;
    
    discardPile = [...discardPile, currentCard!];
    currentCard = null;
    notifyListeners();
    return;
  }

  void discardHand() {
    discardPile = [...discardPile, ...drawnCards];
    drawnCards = [];
    notifyListeners();
    return;
  }
}