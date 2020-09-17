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
  Future<Category> category;
  //To goto the quiz page
  Future navigateToQuizPage(int categoryId) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(categoryId: categoryId)));
  }

  @override
  void initState() {
    category = getCategory();
    super.initState();
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
                            itemCount: snapshot.data.triviaCategories.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 70,
                                child: Center(
                                  child: Card(
                                    color: Colors.blue,
                                    child: ListTile(
                                      onTap: () {
                                        navigateToQuizPage(snapshot
                                            .data.triviaCategories[index].id);
                                      },
                                      leading: Icon(
                                        Icons.celebration,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        snapshot
                                            .data.triviaCategories[index].name,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
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
    );
  }
}
