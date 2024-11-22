import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/QuatesCategoryModel.dart';

final quotesCategoryServiceProvider = Provider((ref) => QuotesService());

class QuotesService {
  final String _url = dotenv.get('BASE_URl', fallback: "");

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

  // Future<QuoteseriesModel> fetchSingleSeries(int id) async {
  //   try {
  //     final apiUrl = '${_url}audioSeason/$id';
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       // final data = jsonDecode(response.body);
  //       return QuoteseriesModel.fromJson(jsonDecode(response.body));
  //       // return data.map((e) => AudioSeason.fromJson(e)).toList();
  //     } else {
  //       throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
  //     }
  //   } catch (e) {
  //     throw "Unable to fetch series: $e";
  //   }
  // }
}
