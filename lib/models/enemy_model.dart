import 'package:flip_7/models/card_model.dart';

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

abstract class Enemy {
  String get name;
  int get health;
  set health(int newHealth);
  List<PlayingCard> get deck;

  void takeTurn();
}

class FirstEnemy implements Enemy {
  @override String name = "First Enemy";
  @override int health = 200;
  @override List<PlayingCard> deck = deckDefinition.entries.expand<PlayingCard>((entry) {
    final String id = entry.key;
    final (:value, :count) = entry.value;

    return List.generate(count, (i) {
      return PlayingCard(value: value, id: '$id-$i');
    });
  }).toList();

  @override
  void takeTurn() {

  }
}