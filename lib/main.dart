import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/models/quiz_model.dart';
import 'package:myquizapp/services/html_encoding_service.dart';
import 'package:myquizapp/services/quiz_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizler',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  Future<Quiz> futureQuiz;
  HtmlEncoding encoding = new HtmlEncoding();
  bool _isVisible = true;

  // TO show the correct answer of a question
  Widget showingAnswer(String correctAns) {
    return Visibility(
      visible: !_isVisible,
      child: Column(
        children: [
          Text(
            'The correct answer is',
            style: TextStyle(fontSize: 20),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              '$correctAns',
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.green,
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                questionNumber++;
                _isVisible = true;
              });
            },
            child: Text(
              'Next Question',
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.red[900],
          )
        ],
      ),
    );
  }

  //To build each option button
  Widget optionButton(
      int number, List<String> options, List<int> list, String correctAns) {
    return Visibility(
      visible: _isVisible,
      child: FlatButton(
        onPressed: () {
          setState(() {
            _isVisible = false;
          });
        },
        child: Text(
          options[list[number]],
          style: TextStyle(fontSize: 20, letterSpacing: 2),
        ),
        color: Colors.blue,
      ),
    );
  }

  //To randomize the options and build the options.
  Widget optionBuilder(String correct_ans, List<String> incorrect_ans) {
    if (correct_ans != null && incorrect_ans != null) {
      List<String> options = [];
      options.add(correct_ans);
      options.addAll(incorrect_ans);
      Random random = new Random();
      List<int> list = [];
      int max = 4;
      while (list.length < 4) {
        int random_num = random.nextInt(max);
        if (!list.contains(random_num)) {
          list.add(random_num);
        }
      }
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              optionButton(0, options, list, correct_ans),
              optionButton(1, options, list, correct_ans),
              optionButton(2, options, list, correct_ans),
              optionButton(3, options, list, correct_ans),
              showingAnswer(correct_ans),
            ],
          ),
        ],
      );
    } else {
      return Text('No Button');
    }
  }

  @override
  void initState() {
    super.initState();
    futureQuiz = getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz from API'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<Quiz>(
              future: futureQuiz,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  String text = encoding.htmlDecoder(
                      snapshot.data.results[questionNumber].question);
                  String correctAns =
                      snapshot.data.results[questionNumber].correct_answer;
                  List<String> incorrectAns =
                      snapshot.data.results[questionNumber].incorrect_answers;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$text',
                        style: TextStyle(fontSize: 25, letterSpacing: 2),
                      ),
                      optionBuilder(correctAns, incorrectAns),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
