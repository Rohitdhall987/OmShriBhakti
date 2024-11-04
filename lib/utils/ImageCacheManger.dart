import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheManager {
  final Dio _dio = Dio();

  // Function to get the image
  Future<File?> getImage(String url) async {
    try {
      // Generate a unique file name from the URL
      final fileName = url.split('/').last;
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      // Check if the image is already stored
      final file = File(filePath);
      if (await file.exists()) {
        // If it exists, return it directly
        return file;
      } else {
        // Download the image and save it locally
        final response = await _dio.download(url, filePath);
        if (response.statusCode == 200) {
          return file;
        }
      }
    } catch (e) {
      print("Error loading image: $e");
    }
    return null;
  }
}
