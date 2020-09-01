import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/models/quiz_model.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Quiz>(
                  future: futureQuiz,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      }
                      return Text(
                        '${snapshot.data.results[questionNumber].question}',
                        style: TextStyle(fontSize: 20),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      questionNumber++;
                    });
                  },
                  child: Text('Next Question'),
                  color: Colors.blue[300],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
