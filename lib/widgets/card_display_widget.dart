import 'package:flip_7/models/card_model.dart';
import 'package:flutter/material.dart';

class CardDisplayWidget extends StatelessWidget {
  final PlayingCard? card;
  final bool isDuplicate;

  const CardDisplayWidget({
    super.key,
    required this.card,
    required this.isDuplicate,
  });

  @override
  Widget build(BuildContext context) {
    if (card == null) return Text('Null card');

    return Text(
      '|${card!.value}|',
      style: TextStyle(
        color: isDuplicate ? Colors.red : Colors.black,
      )
    );
  }
}