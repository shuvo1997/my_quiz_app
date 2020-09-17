import 'package:myquizapp/models/category_model.dart';
import 'package:http/http.dart' as http;

String url = 'https://opentdb.com/api_category.php';
Future<Category> getCategory() async {
  final response = await http.get(url);
  return categoryFromJson(response.body);
}
