import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/QuatesCategoryModel.dart';
import 'package:omshribhakti/model/share_quotes_category_model.dart';

final quotesCategoryServiceProvider = Provider((ref) => QuotesService());

class QuotesService {
  final String _url = dotenv.get('BASE_URl', fallback: "");

  final _apiKey=dotenv.get("API_KEY",fallback: "");

  Future<List<Category>> fetchAllQuotesCategory() async {
    try {
      // Construct the API URL
      final apiUrl ='${_url}ImageStatusCategory';

      // Perform GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final quotes = QuotesCategory.fromJson(data);
        return quotes.category; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch quotes category: $e";
    }
  }

  Future<List<ShareQuotesCategory>> fetchHomeCategories(token) async {
    try {
      // Construct the API URL
      final apiUrl = "${_url}v1/user/home/shareQuotesCategory?apiKey=$_apiKey";



      // Perform GET request
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );


      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        return ShareQuotesCategoryModel.fromJson(jsonDecode(response.body)).shareQuotesCategory;
        // return data.map((e) => AudioSeason.fromJson(e)).toList();
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch series: $e";
    }
  }
}
