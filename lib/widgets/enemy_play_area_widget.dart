import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flip_7/widgets/card_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnemyPlayAreaWidget extends StatelessWidget {
  const EnemyPlayAreaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<PlayingCard> enemyCards = context.select<EnemyCardManager, List<PlayingCard>>((ecm) => ecm.drawnCards);
    PlayingCard? currentCard = context.select<EnemyCardManager, PlayingCard?>((ecm) => ecm.currentCard);

    return Container(
      width: 300,
      height: 100,
      alignment: Alignment.center,
      color: Colors.green.shade200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          ...enemyCards.map((card) {
            return CardDisplayWidget(
              card: card,
              isDuplicate: context.select<EnemyCardManager, bool>(
                (ecm) => ecm.duplicateValue == card.value,
              ),
            );
          }),

          if (currentCard != null)
            CardDisplayWidget(
              card: currentCard,
              isDuplicate: context.select<EnemyCardManager, bool>(
                (ecm) => ecm.isCurrentCardDuplicate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}