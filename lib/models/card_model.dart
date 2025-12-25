typedef DeckDefinition = Map<String, ({int value, int count})>;
const Map<String, ({int value, int count})> playerDeckDefinition = {
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

class PlayingCard {
  final String id;
  final int value;

  PlayingCard({
    required this.id,
    required this.value,
  });

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
    return (other is PlayingCard && 
            other.id == id       &&
            other.value == value);
  }

  @override
  int get hashCode => Object.hash(id, value);
}