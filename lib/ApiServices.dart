import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsify/models/ArticleResponse.dart';

class ApiServices {
  Future<ArticleResponse> fetchArticles() async {
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b353ac5a3f1b46adb5ab0fb062734c5f');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print("res: " + response.body.toString());

      return ArticleResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load articles');
    }
  }
}
