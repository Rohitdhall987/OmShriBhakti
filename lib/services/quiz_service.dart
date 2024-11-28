import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/quiz_category_model.dart';
import 'package:omshribhakti/model/quiz_question_model.dart';

class QuizService {
  final String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<AllQuizCategory>> fetchQuizCategory(String token) async {
    try {
      String url = "${_url}v1/user/home/allQuizCategory?&apiKey=${dotenv.get("API_KEY", fallback: "")}";

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

  Future<List<QuizQuestion>> fetchQuizQuestion({required String token,required int userId,required int categoryId}) async {
    try {
      String url = "${_url}v1/user/home/startQuiz?category_id=$categoryId&user_id=$userId&apiKey=${dotenv.get("API_KEY", fallback: "")}";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final quiz = Quiz.fromJson(data);
        return quiz.quizQuestion;
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch quiz questions: $e";
    }
  }


  Future<dynamic> submitQuiz({required String token,required int userId,required int categoryId,required List<int?> answers ,required List<int> questionsId}) async {
    // try {
      String url = "${_url}v1/user/home/DeclareQuizResult";
       Map<String,String> answerData={};

      for(int i=0;i<questionsId.length;i++){
        String option="A";
        switch(answers[i]){
          case 1:
            option="A";
            break;
          case 2:
            option="B";
            break;
          case 3:
            option="C";
            break;
          case 4:
            option="D";
            break;
        }
        answerData.addAll({questionsId[i].toString():option});
      }

      final data=jsonEncode({
        "category_id":categoryId,
        "user_id":userId,
        "apiKey":dotenv.get("API_KEY", fallback: ""),
        "answers":answerData
      });

      http.Response response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          "Content-Type":"application/json",
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    // } catch (e) {
    //   throw "Unable to fetch quiz result: $e";
    // }
  }

}
