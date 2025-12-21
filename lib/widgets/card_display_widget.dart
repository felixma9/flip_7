import 'package:flip_7/models/card_model.dart';
import 'package:flutter/widgets.dart';

class CardDisplayWidget extends StatelessWidget {
  final PlayingCard? card;

  const CardDisplayWidget({
    super.key,
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    if (card == null) return Text("Null card");
    return Text('|${card!.value}|');
  }
}