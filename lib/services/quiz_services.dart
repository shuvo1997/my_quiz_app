import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:myquizapp/models/quiz_model.dart';

class QuizServices {
  String url = 'https://opentdb.com/api.php?amount=10&type=multiple';

  Future<Quiz> getCategoryQuiz(int id, String token) async {
    final response =
        await http.get(Uri.parse('$url&category=$id&token=$token'));
    return quizFromJson(response.body);
  }

  Future<Quiz> getRandomQuiz(String token) async {
    final response = await http.get(Uri.parse('$url&token=$token'));
    return quizFromJson(response.body);
  }
}
