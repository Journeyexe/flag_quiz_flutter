import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_bandeiras/pages/home/score_page.dart';
import 'package:projeto_bandeiras/utils/load_json.dart';
import 'package:projeto_bandeiras/utils/select_flags.dart';

class QuizPage extends StatefulWidget {
  final int duration;

  const QuizPage({super.key, required this.duration});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  late List<Map<String, dynamic>> countries = [];
  late List<Map<String, dynamic>> options = [];
  late Map<String, dynamic> correctAnswer;
  late Widget flagWidget;
  int score = 0;
  int totalQuestions = 0;
  late Timer timer;
  late int timeLeft;
  bool isLoading = true;
  Map<String, Color> buttonColors = {};

  @override
  void initState() {
    super.initState();
    timeLeft = widget.duration;
    loadGameData();
  }

  Future<void> loadGameData() async {
    countries = await loadJson();
    setNewQuestion();
    setState(() {
      isLoading = false;
    });
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          t.cancel();
          endQuiz();
        }
      });
    });
  }

  void setNewQuestion() {
    final selectedFlags = selectFlags(countries);
    correctAnswer = selectedFlags[0];
    options = List<Map<String, dynamic>>.from(selectedFlags)..shuffle();

    // Precarrega a imagem da bandeira
    flagWidget = FutureBuilder(
      future: precacheImage(AssetImage(correctAnswer['bandeira']), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.asset(
            correctAnswer['bandeira'],
            fit: BoxFit.contain,
            height: 200,
            width: 300,
          );
        } else {
          return const SizedBox(
            height: 200,
            width: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );

    setState(() {
      buttonColors = {};
      totalQuestions++;
    });
  }

  void checkAnswer(Map<String, dynamic> answer) {
    setState(() {
      if (answer == correctAnswer) {
        buttonColors[answer['nome']] = Colors.green;
        score++;
      } else {
        buttonColors[answer['nome']] = Colors.red;
        buttonColors[correctAnswer['nome']] = Colors.green;
      }
    });

    // Espera 1 segundo antes de carregar a próxima pergunta
    Future.delayed(const Duration(seconds: 1), () {
      setNewQuestion();
    });
  }

  void endQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(score: score, totalQuestions: totalQuestions-1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flag Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Time Left: $timeLeft seconds'),
          flagWidget, // Usa o widget armazenado
          Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return Container(
                width: double.infinity, // Botões com largura total
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColors[option['nome']] ?? Colors.blue, // Define a cor do botão
                  ),
                  onPressed: () => checkAnswer(option),
                  child: Text(option['nome']),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
