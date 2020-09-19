import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/models/category_model.dart';
import 'package:myquizapp/screens/CategoryPage.dart';
import 'package:myquizapp/screens/FinishPage.dart';
import 'package:myquizapp/screens/QuizPage.dart';
import 'package:myquizapp/screens/Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzing',
      home: Wrapper(),
      routes: {
        "/categorypage": (_) => CategoryPage(),
      },
    );
  }
}
