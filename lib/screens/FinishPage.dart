import 'package:flutter/material.dart';

class FinishPage extends StatefulWidget {
  final int score;
  FinishPage({@required this.score});

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  // TODO: implement widget
  FinishPage get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Image.asset('images/congo1.jpg'),
              ),
            ),
            Text(
              'You have answered all the questions.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your score is:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.score.toString(),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                child: Text(
                  'Try again',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/categorypage");
                },
                color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
