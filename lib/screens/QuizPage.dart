import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/models/quiz_model.dart';
import 'package:myquizapp/services/html_encoding_service.dart';
import 'package:myquizapp/services/quiz_services.dart';

class QuizPage extends StatefulWidget {
  final int categoryId;

  QuizPage({@required this.categoryId});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  Future<Quiz> futureQuiz;
  HtmlEncoding encoding = new HtmlEncoding();
  bool _isVisible = true;
  List<Icon> scorekeeper = [];
  int numberOfCorrectAns = 0;
  List<Icon> progressBar = [];
  //TODO: add category screen
  //TODO: add a finishing screen
  //TODO: Add a leaderboard
  @override
  // TODO: implement widget

  //To get arguments from Stateless widget
  QuizPage get widget => super.widget;

  void progressBarBuilder() {
    progressBar = [];
    for (int i = 0; i < 10; i++) {
      progressBar.add(Icon(
        Icons.check_box_outline_blank,
        color: Colors.blue,
      ));
    }
  }

  //To check a answer
  bool checkAnswer(String correctAns, String userPickedAns) {
    if (userPickedAns == correctAns) {
      scorekeeper.add(Icon(
        Icons.check,
        color: Colors.green[900],
      ));
      numberOfCorrectAns++;
      return true;
    } else {
      scorekeeper.add(Icon(
        Icons.close,
        color: Colors.red[900],
      ));
      return false;
    }
  }

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
                if (questionNumber < 9) {
                  questionNumber++;
                  _isVisible = true;
                } else {} //TODO : Take another 10 quiz
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
    String userPickedAns = options[list[number]];
    return Visibility(
      visible: _isVisible,
      child: FlatButton(
        onPressed: () {
          setState(() {
            progressBar[questionNumber] = Icon(
              Icons.check_box,
              color: Colors.blue,
            );
            if (checkAnswer(correctAns, userPickedAns)) {
              questionNumber++;
            } else {
              _isVisible = false;
            }
          });
        },
        child: Text(
          userPickedAns,
          style: TextStyle(fontSize: 18, letterSpacing: 2),
        ),
        color: Colors.blue,
      ),
    );
  }

  //To randomize the options and build the options.
  Widget optionBuilder(String correct_ans, List<String> incorrect_ans) {
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
  }

  @override
  void initState() {
    super.initState();
    futureQuiz = getQuiz();
    progressBarBuilder();
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
                  String category =
                      snapshot.data.results[questionNumber].category;
                  String difficulty =
                      snapshot.data.results[questionNumber].difficulty;
                  String correctAns =
                      snapshot.data.results[questionNumber].correctAnswer;
                  List<String> incorrectAns =
                      snapshot.data.results[questionNumber].incorrectAnswer;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.categoryId.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: progressBar,
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$text',
                                style:
                                    TextStyle(fontSize: 25, letterSpacing: 2),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Category: $category',
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 2),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Difficulty: $difficulty',
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: optionBuilder(correctAns, incorrectAns),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: scorekeeper,
                      )
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
