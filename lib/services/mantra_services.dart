import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/MantraModel.dart';
import 'package:http/http.dart' as http;

final mantrasServiceProvider = Provider((ref) => MantrasService());

class MantrasService {
  String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<Mantras>> fetchMantras(int? lastGodId) async {
    try {
      // Construct the API URL
      final apiUrl = lastGodId != null
          ? '${_url}mantra/$lastGodId'
          : '${_url}mantra';

      // Perform GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final mantras = MantraModel.fromJson(data);
        return mantras.mantras; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch Mantras: $e";
    }
  }
}
