// This manager is a singleton, and represents the 
// GROUND TRUTH for the remaining cards in the deck
import 'package:flip_7/models/card_model.dart';
import 'package:flutter/foundation.dart';

const Map<String, ({int value, int count})> deckDefinition = {
  'zero':   (value: 0,  count: 1),
  'one':    (value: 1,  count: 1),
  'two':    (value: 2,  count: 2),
  'three':  (value: 3,  count: 3),
  'four':   (value: 4,  count: 4),
  'five':   (value: 5,  count: 5),
  'six':    (value: 6,  count: 6),
  'seven':  (value: 7,  count: 7),
  'eight':  (value: 8,  count: 8),
  'nine':   (value: 9,  count: 9),
  'ten':    (value: 10, count: 10),
  'eleven': (value: 11, count: 11),
  'twelve': (value: 12, count: 12),
};

class CardManager extends ChangeNotifier {
  List<PlayingCard> deck = [];
  List<PlayingCard> drawnCards = [];
  List<PlayingCard> discardPile = [];

  // Invariant: currentCard is NOT part of the player's hand on first
  //            draw, it enters the hand if it's valid and on next draw
  PlayingCard? currentCard;

  int get pointsInHand {
    int points = 0;
    for (PlayingCard card in drawnCards) {
      points += card.value;
    }

    int currentCardPoints = currentCard?.value ?? 0;
    return points + currentCardPoints;
  }
  
  bool get isCurrentCardDuplicate {
    if (currentCard == null) return false;
    return drawnCards.any((card) => card.value == currentCard!.value);
  }

  int? get duplicateValue {
    if (currentCard == null) return null;
    return drawnCards.any((card) => card.value == currentCard!.value) 
      ? currentCard!.value : null;
  }

  CardManager() {
    resetDeck();
  }

  void resetDeck() {
    deck = deckDefinition.entries.expand<PlayingCard>((entry) {
      final String id = entry.key;
      final (:value, :count) = entry.value;

      return List.generate(count, (i) => PlayingCard(value: value, id: '$id-$i'));
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