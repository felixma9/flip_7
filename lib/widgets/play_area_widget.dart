// Play area, displays player's cards AND when a
// card is dragged into it the player draws a card

import 'package:flutter/material.dart';

class PlayAreaWidget extends StatelessWidget {
  const PlayAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => print("Card dropped"),
      builder:(context, candidateData, rejectedData) => 
        Container(
            width: 300,
            height: 200,
            alignment: Alignment.center,
            color: Colors.green.shade200,
            child: Text("Drag here"),
        )
    );
  }
}