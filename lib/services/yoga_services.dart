import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/YogaByCategory.dart';
import 'package:omshribhakti/model/home_yoga_list_model.dart';
import 'package:omshribhakti/model/yoga_category_model.dart';

final yogaCategoryServiceProvider = Provider((ref) => YogaService());

class YogaService {
  final String _url = dotenv.get('BASE_URl', fallback: "");
  final String apiKey = dotenv.get('API_KEY', fallback: "");

  Future<List<AllYogaCategories>> fetchAllYogaCategory(token) async {
    try {
      // Construct the API URL
      final apiUrl ='${_url}v1/user/AllYogaCategory?apiKey=$apiKey';

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
        // print(response.body);
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch yoga category: $e '${_url}v1/user/AllYogaCategory?apiKey=$apiKey'";
    }
  }

Future<List<AllYoga>> fetchYogaByCategory(token,id) async {
  try {
    final apiUrl = '${_url}v1/user/AllYogaByCategory?category_id=$id&apiKey=$apiKey';
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        });

    if (response.statusCode == 200) {
      return AllYogaByCategory.fromJson(jsonDecode(response.body)).allYoga;
    } else {
      throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
    }
  } catch (e) {
    throw "Unable to fetch yoga by category: $e";
  }
}


  Future<List<YogaList>> fetchYogaByApi(api,token,lastId) async {
    try {
      final apiUrl = '${_url}v1/user/$api?last_id=$lastId&apiKey=$apiKey';
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          });

      if (response.statusCode == 200) {
        return HomeYogaListModel.fromJson(jsonDecode(response.body)).yogaList;
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch Home yoga $api: $e";
    }
  }
}
