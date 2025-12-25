// Deck widget represents the deck VISUALLY,
// player can DRAG a card from this widget to their
// play area to draw a card

import 'package:flip_7/logic/card_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeckWidget extends StatelessWidget {
  const DeckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final int deckSize = context.select<PlayerCardManager, int>((cm) => cm.deck.length);

    if (deckSize == 0) return const Text('Deck empty');

    return Draggable(
      data: 'dummy data',
      feedback: Text(
          '🂠',
          style: TextStyle(fontSize: 64),
        ),
      child: Text(
        '$deckSize',
        style: TextStyle(fontSize: 64),
      ),
    );
  }
}