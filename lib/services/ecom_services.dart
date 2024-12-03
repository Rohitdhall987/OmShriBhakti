


import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:omshribhakti/model/product_by_category.dart';
import 'package:omshribhakti/model/product_category.dart';
import 'package:http/http.dart'as http;
import 'package:omshribhakti/model/random_products_model.dart';
import 'package:omshribhakti/model/trending_products.dart';

class EcomServices {
  final _baseUrl = dotenv.get("BASE_URl", fallback: "");
  final _apiKey = dotenv.get("API_KEY", fallback: "");

  Future<List<Catgeory>> fetchProductCategory(token) async {
    try {
      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/allCategory?apiKey=$_apiKey";



      // Perform GET request
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return ProductCategories.fromJson(data).catgeory;
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category by id : $e";
    }
  }
  Future<List<SingleCategoryProducts>> fetchProductByCategory(token,id) async {
    try {
      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/singleCategoryProduct?apiKey=$_apiKey&category_id=$id";




      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);




        return ProductByCategoryModel.fromJson(data).singleCategoryProducts;
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category by id : $e";
    }
  }

  Future<TrendingProductModel> fetchTrendingProducts(String token) async {
    try {
      String url = "${_baseUrl}v1/user/home/trendingProducts?apiKey=$_apiKey";

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

  Future<Map<String,dynamic>> fetchProductsDetails(String token,id) async {
    try {
      String url = "${_baseUrl}v1/user/singleViewProduct?apiKey=$_apiKey&product_id=$id";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch trending products: $e";
    }
  }
  Future<List<RandomProducts>> fetchRandomProducts(String token,int? lastId) async {
    try {
      String url = "${_baseUrl}v1/user/allRandomProducts?apiKey=$_apiKey&last_id=$lastId";


      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {

        return RandomProductsModel.fromJson(jsonDecode(response.body)).randomProducts;
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch trending products: $e";
    }
  }
}

