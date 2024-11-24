import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/yoga_category_model.dart';

final yogaCategoryServiceProvider = Provider((ref) => YogaService());

class YogaService {
  final String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<AllYogaCategories>> fetchAllYogaCategory(token) async {
    try {
      // Construct the API URL
      final apiUrl ='${_url}user/AllYogaCategory';

      // Perform POST request
      final response = await http.post(Uri.parse(apiUrl),
      headers: {
        HttpHeaders.authorizationHeader:"Bearer $token"
      });

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final yoga = YogaCategory.fromJson(data);
        return yoga.allYogaCategories; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch yoga category: $e '${_url}user/AllYogaCategory'";
    }
  }

// Future<QuoteseriesModel> fetchSingleCategory(int id) async {
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
