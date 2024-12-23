import 'package:flutter/material.dart';
import 'package:projeto_bandeiras/pages/home/quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flag Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => startQuiz(context, 30),
              child: const Text('30 Seconds'),
            ),
            ElevatedButton(
              onPressed: () => startQuiz(context, 60),
              child: const Text('60 Seconds'),
            ),
            ElevatedButton(
              onPressed: () => startQuiz(context, 180),
              child: const Text('3 Minutes'),
            ),
            ElevatedButton(
              onPressed: () => startQuiz(context, 300),
              child: const Text('5 Minutes'),
            ),
          ],
        ),
      ),
    );
  }

  void startQuiz(BuildContext context, int duration) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(duration: duration),
      ),
    );
  }
}