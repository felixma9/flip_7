import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/logic/enemy_manager.dart';
import 'package:flip_7/logic/game_manager.dart';
import 'package:flip_7/models/enemy_model.dart';
import 'package:flip_7/widgets/deck_widget.dart';
import 'package:flip_7/widgets/enemy_display_widget.dart';
import 'package:flip_7/widgets/play_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardManager()),
        ChangeNotifierProvider(create: (_) => EnemyManager()),
        ChangeNotifierProxyProvider2<CardManager, EnemyManager, GameManager>(
          create: (context) => GameManager(context.read<CardManager>(), context.read<EnemyManager>()),
          update:(_, cardManager, enemyManager, gameManager) => gameManager ?? GameManager(cardManager, enemyManager),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final int accumulatedPoints = context.select<CardManager, int>((cm) => cm.pointsInHand);
    final int totalPoints = context.select<GameManager, int>((gm) => gm.totalPoints);
    final Enemy? currentEnemy = context.select<EnemyManager, Enemy?>((em) => em.currentEnemy);
    final double chanceToBust = context.select<CardManager, double>((cm) => cm.chanceToBust);
    final bool isCurrentCardDuplicate = context.select<CardManager, bool>((cm) => cm.isCurrentCardDuplicate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enemy
            if (currentEnemy != null)
              EnemyDisplayWidget(enemy: currentEnemy),

            // Deck
            DeckWidget(),

            // Accumulated points
            Text('Accumulated points: ${accumulatedPoints.toString()}'),

            // Total points
            Text('Total points: ${totalPoints.toString()}'),

            // Play area
            PlayAreaWidget(),
            
            // Chance to bust
            if (!isCurrentCardDuplicate) Text('${chanceToBust.toStringAsFixed(2)}% to bust'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // End turn button
          FloatingActionButton(
            onPressed: () => context.read<GameManager>().onEndTurn(),
            child: Text('End Turn'),
          ),

          // Draw card button
          FloatingActionButton(
            onPressed: () => context.read<GameManager>().onDrawCard(),
            child: Text('Draw Card'),
          ),

          // Reset button
          FloatingActionButton(
            onPressed: () => context.read<GameManager>().onRestartRound(),
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }
}
