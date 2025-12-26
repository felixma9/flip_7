import 'package:flip_7/logic/enemy_manager.dart';
import 'package:flip_7/models/enemy_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EnemyDisplayWidget extends StatelessWidget {
  final Enemy enemy;

  const EnemyDisplayWidget({
    super.key,
    required this.enemy,
  });

  @override
  build(BuildContext context) {
    final int? enemyHealth = context.select<EnemyManager, int?>((em) => em.health);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (enemyHealth != null) Text('$enemyHealth'),
      ],
    );
  }
}