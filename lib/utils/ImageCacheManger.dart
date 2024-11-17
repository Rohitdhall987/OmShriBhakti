import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheManager {
  final Dio _dio = Dio();

  /// Clear the image cache
  Future<void> clear() async {
    try {
      print("Clearing image cache...");
      final dir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(dir.path);
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
    } catch (e) {
      print("Error clearing cache: $e");
    }
  }

  /// Get the image file from cache or download it
  Future<File?> getImage(String url) async {
    try {
      final fileName = url.split('/').last;
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Check if the file exists and is valid
      if (await file.exists() && isValidImage(file)) {
        print("Image found in cache: $filePath");
        return file;
      }

      // Download the image
      print("Downloading image: $url");
      final response = await _dio.download(url, filePath);
      if (response.statusCode == 200 && await file.length() > 0 && isValidImage(file)) {
        print("Image successfully downloaded: $filePath");
        return file;
      } else {
        print("Invalid or corrupted image downloaded: $filePath");
        file.deleteSync(); // Delete invalid file
      }
    } catch (e) {
      print("Error loading image: $e");
    }
    return null;
  }

  /// Validate the image file
  bool isValidImage(File file) {
    try {
      final bytes = file.readAsBytesSync();
      return bytes.isNotEmpty;
    } catch (e) {
      print("Error validating image: $e");
      return false;
    }
  }
}
