import 'package:flip_7/logic/card_manager.dart';
import 'package:flip_7/logic/game_manager.dart';
import 'package:flip_7/models/card_model.dart';
import 'package:flip_7/widgets/card_display_widget.dart';
import 'package:flip_7/widgets/deck_widget.dart';
import 'package:flip_7/widgets/play_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardManager()),
        ChangeNotifierProxyProvider<CardManager, GameManager>(
          create: (context) => GameManager(context.read<CardManager>()),
          update: (_, cardManager, gameManager) => gameManager ?? GameManager(cardManager)
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Deck
            DeckWidget(),

            // Accumulated points
            Text('Accumulated points: ${accumulatedPoints.toString()}'),

            // Total points
            Text('Total points: ${totalPoints.toString()}'),

            // Play area
            PlayAreaWidget(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // End turn button
          FloatingActionButton(
            onPressed: () => context.read<GameManager>().endTurn(),
            child: Text("End Turn"),
          ),

          // Draw card button
          FloatingActionButton(
            onPressed: () => context.read<GameManager>().drawCard(),
            child: Text("Draw Card"),
          ),
        ],
      ),
    );
  }
}
