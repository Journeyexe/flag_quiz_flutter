import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadJson() async {
  final String jsonString = await rootBundle.loadString('assets/paises.json');
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  return List<Map<String, dynamic>>.from(jsonData['paises']);
}