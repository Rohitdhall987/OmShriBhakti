import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/quiz_category_model.dart';

class QuizService {
  String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<AllQuizCategory>> fetchQuizCategory(String token) async {
    try {
      String url = "https://m.omshribhakti.com/api/v1/user/home/allQuizCategory?&apiKey=${dotenv.get("API_KEY", fallback: "")}";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final quiz = QuizCategoryModel.fromJson(data);
        return quiz.allQuizCategory; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch quiz: $e";
    }
  }


}
