// Deck widget represents the deck VISUALLY,
// player can DRAG a card from this widget to their
// play area to draw a card

import 'package:flutter/material.dart';

class DeckWidget extends StatelessWidget {
  const DeckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: "dummy",
      feedback: Text("test feedback"),
      child: Text("deck here"),
    );
  }
}