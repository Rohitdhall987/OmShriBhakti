import 'dart:io';
import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/utils/ImageCacheManger.dart';

final Map<String, ImageProvider> _cachedImageProviders = {}; // Cache for loaded images

Widget cachedNetworkImage(String url, BoxFit fit) {

  // return Image.network(url,fit: fit,);

  ///TODO: image cache management
  final ImageCacheManager _cacheManager = ImageCacheManager();

  // Check if the image is already cached
  if (_cachedImageProviders.containsKey(url)) {
    //print("Cache hit for URL: $url");
    return Image(
      image: _cachedImageProviders[url]!,
      fit: fit,
      errorBuilder: (context,image,stackTrack){
        //print(image.toString());
        //print(stackTrack.toString());
        return Image.network(url);
      },
    );
  }

  // Otherwise, fetch the image and cache it
  return FutureBuilder<File?>(
    future: _cacheManager.getImage(url),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          final file = snapshot.data!;
          if (_cacheManager.isValidImage(file)) {
            //print("Caching image for URL: $url");
            final imageProvider = FileImage(file);
            _cachedImageProviders[url] = imageProvider;
            return Image(
              image: imageProvider,
              fit: fit,
              errorBuilder: (context,image,stackTrack){
                //print(image.toString());
                //print(stackTrack.toString());
                return Image.network(url);
              },
            );
          } else {
            //print("Invalid cached image for URL: $url");
          }
        } else {
          //print("Image loading failed for URL: $url");
        }

        // Fallback to NetworkImage if cache fails
        //print("Falling back to network image for URL: $url");
        final imageProvider = NetworkImage(url);
        _cachedImageProviders[url] = imageProvider;
        return Image(
          image: imageProvider,
          fit: fit,
          errorBuilder: (context,image,stackTrack){
            //print(image.toString());
            //print(stackTrack.toString());
            return Image.network(url);
          },
        );
      }

      // Placeholder during loading
      return Container(
        color: AppTheme.background,
        child: Center(child: CircularProgressIndicator()),
      );
    },
  );
}

Future<ImageProvider> getImageProvider(String url) async {

  // return NetworkImage(url);

  final ImageCacheManager cacheManager = ImageCacheManager();
  final file = await cacheManager.getImage(url);
  if (file != null && cacheManager.isValidImage(file)) {
    return FileImage(file);
  } else {
    return NetworkImage(url);
  }
}
