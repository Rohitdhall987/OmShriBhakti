import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/LiveDarshanModel.dart';

final liveDarshanServiceProvider = Provider((ref) => LiveDarshanService());

class LiveDarshanService {
  String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<LiveDarshan>> fetchAllLiveDarshans(int? lastGodId) async {
    try {
      // Construct the API URL
      final apiUrl = lastGodId != null
          ? '${_url}liveDarshan/$lastGodId'
          : '${_url}liveDarshan';

      // Perform GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final liveDarshan = LiveDarshanModel.fromJson(data);
        return liveDarshan.liveDarshan; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch podcast: $e";
    }
  }
}
