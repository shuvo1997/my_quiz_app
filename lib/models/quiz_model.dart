import 'dart:convert';

Quiz quizFromJson(String str) {
  final jsonData = json.decode(str);
  return Quiz.fromJson(jsonData);
}

class Quiz {
  final int responseCode;
  final List<Result> results;

  Quiz({this.responseCode, this.results});

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        responseCode: json['response_code'],
        results:
            List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
      );
}

class Result {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correct_answer;
  final List<String> incorrect_answers;

  Result(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correct_answer,
      this.incorrect_answers});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correct_answer: json['correct_answer'],
      incorrect_answers:
          List<String>.from(json['incorrect_answers'].map((x) => x)));
}
