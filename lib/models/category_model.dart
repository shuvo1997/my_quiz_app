import 'dart:convert';
// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String quizToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.triviaCategories,
  });

  List<TriviaCategory> triviaCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    triviaCategories: List<TriviaCategory>.from(json["trivia_categories"].map((x) => TriviaCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trivia_categories": List<dynamic>.from(triviaCategories.map((x) => x.toJson())),
  };
}

class TriviaCategory {
  TriviaCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory TriviaCategory.fromJson(Map<String, dynamic> json) => TriviaCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
