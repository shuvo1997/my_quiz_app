import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/models/sessiontoken_model.dart';
import 'package:myquizapp/screens/QuizPage.dart';
import 'package:myquizapp/services/category_services.dart';
import 'package:myquizapp/models/category_model.dart';
import 'package:myquizapp/services/sessiontoken_services.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<Category> category;
  Future<SessionToken> token;
  String tokenString;
  bool visible = true;
  String appBarMsg = 'Quizzing App';

  //To goto the quiz page
  Future navigateToQuizPage(int categoryId) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  categoryId: categoryId,
                  token: tokenString,
                )));
  }

  void alterVisibility() {
    visible = !visible;
  }

  Widget setText(String text) {
    return Text(text);
  }

  @override
  void initState() {
    super.initState();
    category = getCategory();
    token = getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: setText(appBarMsg)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: visible,
                child: FutureBuilder(
                    future: token,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        //print(snapshot.data.token);
                        tokenString = snapshot.data.token;
                        if (snapshot.hasError) {
                          return Text('Error');
                        }
                        return Column(
                          children: [
                            Container(
                              child: Image.asset('images/welcome2.png'),
                              padding: EdgeInsets.all(10),
                              height: 300,
                            ),
                            Text(
                              'Welcome To Quizzing App',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              child: Text(
                                'Lets Start Quizzing',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  alterVisibility();
                                  appBarMsg = 'Browse Categories';
                                });
                              },
                              color: Colors.blue,
                            )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Visibility(
                visible: !visible,
                child: Expanded(
                  child: FutureBuilder<Category>(
                    future: category,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error');
                        }
                        return Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Card(
                                      color: Colors.red[900],
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.category,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          'Take 10 Random Quiz',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          navigateToQuizPage(0);
                                        },
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Take 10 quiz from below',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 6,
                                child: ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount:
                                        snapshot.data.triviaCategories.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 70,
                                        child: Center(
                                          child: Card(
                                            color: Colors.blue,
                                            child: ListTile(
                                              onTap: () {
                                                navigateToQuizPage(snapshot
                                                    .data
                                                    .triviaCategories[index]
                                                    .id);
                                              },
                                              leading: Icon(
                                                Icons.celebration,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                snapshot
                                                    .data
                                                    .triviaCategories[index]
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
