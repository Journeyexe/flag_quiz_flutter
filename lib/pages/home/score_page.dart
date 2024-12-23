import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScorePage({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
  final String porcentagem = (100 / totalQuestions * score).toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You got $score out of $totalQuestions correct!'),
            Text('$porcentagem%'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}