import "dart:convert";
import "dart:io";

import "package:flutter_dotenv/flutter_dotenv.dart";
import"package:http/http.dart" as http;
import "package:omshribhakti/model/article_series_by_month.dart";
import "package:omshribhakti/model/month_article.dart";
import "package:omshribhakti/model/monthly_articles_model.dart";

class ArticleService{
  final _baseUrl=dotenv.get("BASE_URl",fallback: "");
  final _apiKey=dotenv.get("API_KEY",fallback: "");
  Future<List<MonthCategory>> fetchMonthlyCategory(token)async{

    try {


      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/articleMonthCategories?apiKey=$_apiKey";



      // Perform GET request
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);



        return MonthlyArticlesModel.fromJson(data).monthCategory;
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category: $e";
    }
  }


  Future<SingleMonthArticle> fetchMonthlySingleArticleById(token,id,int? lastId)async{

    try {


      final apiUrl = "${_baseUrl}v1/user/singleArticlesByMonthCategory?apiKey=$_apiKey&month_category_id=$id&${lastId==null?'':'last_id=$lastId'}";



      // Perform GET request
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);



        return SingleMonthArticle.fromJson(data);
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category by id : $e";
    }
  }

  Future<SingleMonthArticleSeries> fetchMonthlyArticleSeriesById(token,id)async{

    try {


      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/articleSeriesByMonthCategory?apiKey=$_apiKey&month_category_id=$id";



      // Perform GET request
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);



        return SingleMonthArticleSeries.fromJson(data);
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category by id : $e";
    }
  }
}