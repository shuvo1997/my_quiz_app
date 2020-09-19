import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:myquizapp/models/sessiontoken_model.dart';

String url = 'https://opentdb.com/api_token.php?command=request';

Future<SessionToken> getToken() async {
  final response = await http.get('$url');
  return tokenFromJson(response.body);
}
