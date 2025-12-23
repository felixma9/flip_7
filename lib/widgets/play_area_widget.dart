// Play area, displays player's cards AND when a
// card is dragged into it the player draws a card

import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/logic/game_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flip_7/widgets/card_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayAreaWidget extends StatelessWidget {
  const PlayAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PlayingCard> drawnCards = context.select<CardManager, List<PlayingCard>>((cm) => cm.drawnCards);
    final PlayingCard? currentCard = context.select<CardManager, PlayingCard?>((cm) => cm.currentCard);

    return DragTarget<PlayingCard>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => context.read<GameManager>().onDrawCard(),
      builder: (context, candidateData, rejectedData) => 
        Container(
            width: 300,
            height: 200,
            alignment: Alignment.center,
            color: Colors.green.shade200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                ...drawnCards.map((card) {
                  return CardDisplayWidget(card: card);
                }),

                if (currentCard != null)
                  CardDisplayWidget(card: currentCard),
              ],
            ),
          ),
        )
    );
  }
}