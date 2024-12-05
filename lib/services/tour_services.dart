




import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart'as http;
import 'package:omshribhakti/model/random_tours.dart';
import 'package:omshribhakti/model/tour_category_model.dart';
import 'package:omshribhakti/model/tour_trips_model.dart';

class TourServices {
  final _baseUrl = dotenv.get("BASE_URl", fallback: "");
  final _apiKey = dotenv.get("API_KEY", fallback: "");

  Future<TourCategoryModel> fetchTourCategory(token) async {
    try {
      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/getTripCategories?apiKey=$_apiKey";




      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return TourCategoryModel.fromJson(data);
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch monthly category by id : $e";
    }
  }
  Future<List<AllTrips>> fetchTourByCategory(token,id,lastId) async {
    try {
      // Construct the API URL
      final apiUrl = "${_baseUrl}v1/user/getAllTripsByCategory?apiKey=$_apiKey&category_id=$id&last_id=$lastId";




      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token"
          }
      );



      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);


        return TourTripsModel.fromJson(data).allTrips;
      }
      else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch tour by category: $e";
    }
  }


  
  Future<List<RandomTrip>> fetchRandomTours(String token) async {
    try {
      String url = "${_baseUrl}v1/user/getRandomTrips?apiKey=$_apiKey";


      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      // Check if the response status is successful
      if (response.statusCode == 200) {



        return RandomToursModel.fromJson(jsonDecode(response.body)).randomTrip;
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch random Tours: $e";
    }
  }
}

