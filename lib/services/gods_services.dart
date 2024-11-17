import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/GodsModel.dart';
import 'package:omshribhakti/model/Video.dart';
import 'package:http/http.dart' as http;

final godsServiceProvider = Provider((ref) => GodsService());

class GodsService {
  String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<AllGod>> fetchGods(int? lastGodId) async {
    try {
      // Construct the API URL
      final apiUrl = lastGodId != null
          ? '${_url}allGod/$lastGodId'
          : '${_url}allGod';

      // Perform GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final gods = GodsModel.fromJson(data);
        return gods.allGod; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch Gods: $e";
    }
  }
}
