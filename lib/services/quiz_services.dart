import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:myquizapp/models/quiz_model.dart';

String url = 'https://opentdb.com/api.php?amount=10';

Future<Quiz> getQuiz() async {
  final response = await http.get('$url');
  return quizFromJson(response.body);
}
