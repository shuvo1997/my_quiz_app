import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/screens/QuizPage.dart';
import 'package:myquizapp/services/category_services.dart';
import 'package:myquizapp/models/category_model.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //To goto the quiz page
  Future navigateToQuizPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuizPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Category>(
            future: getCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.triviaCategories.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 70,
                        child: Center(
                          child: Card(
                            color: Colors.blue,
                            child: ListTile(
                              onTap: navigateToQuizPage,
                              leading: Icon(Icons.celebration),
                              title: Text(
                                snapshot.data.triviaCategories[index].name,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
