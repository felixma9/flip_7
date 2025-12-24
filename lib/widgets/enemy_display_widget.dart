import 'package:flip_7/models/enemy_model.dart';
import 'package:flutter/widgets.dart';

class EnemyDisplayWidget extends StatelessWidget {
  final Enemy enemy;

  const EnemyDisplayWidget({
    super.key,
    required this.enemy,
  });

  @override
  build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${enemy.health}'),
      ],
    );
  }
}