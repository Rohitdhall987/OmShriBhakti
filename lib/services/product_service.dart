import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/trending_products.dart';

class ProductService {
  final String _url = dotenv.get('BASE_URl', fallback: "");

  Future<TrendingProductModel> fetchTrendingProducts(String token) async {
    try {
      String url = "${_url}v1/user/home/trendingProducts?apiKey=${dotenv.get("API_KEY", fallback: "")}";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TrendingProductModel.fromJson(data);
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch trending products: $e";
    }
  }

}
