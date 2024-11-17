import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/ShalokModel.dart';

class ShlokaService {
  static  String baseUrl = dotenv.get('BASE_URl', fallback: "");

  Future<ShalokModel?> fetchShloka(int adhyaya, int shloka) async {
    final url = Uri.parse('${baseUrl}shalok/$adhyaya/$shloka');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return ShalokModel.fromJson(json.decode(response.body));
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    return null;
  }
}
