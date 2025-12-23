import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDisplayWidget extends StatelessWidget {
  final PlayingCard? card;

  const CardDisplayWidget({
    super.key,
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    if (card == null) return Text('Null card');
    final bool isDuplicate = context.select<CardManager, bool>((cm) => cm.duplicateValue == card!.value);

    return Text(
      '|${card!.value}|',
      style: TextStyle(
        color: isDuplicate ? Colors.red : Colors.black,
      )
    );
  }
}