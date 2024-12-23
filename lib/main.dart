// main.dart
import 'package:flutter/material.dart';
import 'package:projeto_bandeiras/pages/home/home_page.dart';

void main() {
  runApp(const FlagQuizApp());
}

class FlagQuizApp extends StatelessWidget {
  const FlagQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flag Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}