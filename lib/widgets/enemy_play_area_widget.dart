import 'package:flutter/material.dart';

class EnemyPlayAreaWidget extends StatelessWidget {
  const EnemyPlayAreaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      alignment: Alignment.center,
      color: Colors.green.shade200,
    );
  }
}