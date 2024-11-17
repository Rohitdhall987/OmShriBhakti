import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/Video.dart';
import 'package:http/http.dart' as http;

final videoServiceProvider = Provider((ref) => VideoService());

class VideoService {
  String _url = dotenv.get('BASE_URl', fallback: "");

  Future<List<Video>> fetchVideos(int? lastVideoId) async {
    try {
      // Construct the API URL
      final apiUrl = lastVideoId != null
          ? '${_url}Video/$lastVideoId'
          : '${_url}Video';

      // Perform GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response status is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the JSON into a Videos object
        final videos = VideosModel.fromJson(data);
        return videos.video; // Return the list of Video objects
      } else {
        throw "API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Unable to fetch videos: $e";
    }
  }
}
