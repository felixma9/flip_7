// Deck widget represents the deck VISUALLY,
// player can DRAG a card from this widget to their
// play area to draw a card

import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flip_7/widgets/card_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeckWidget extends StatelessWidget {
  const DeckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayingCard? card = context.watch<CardManager>().currentCard;

    if (card == null) return const Text("No card drawn");

    return Draggable<PlayingCard>(
      data: card,
      feedback: CardDisplayWidget(card: card),
      child: CardDisplayWidget(card: card),
    );
  }
}