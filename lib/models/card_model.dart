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