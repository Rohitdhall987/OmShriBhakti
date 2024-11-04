import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/ImageCacheManger.dart';

Widget cachedNetworkImage(String url) {

  ImageCacheManager cacheManager=ImageCacheManager();

  return FutureBuilder(
    future: cacheManager.getImage(url),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        return Image.file(snapshot.data!);
      } else if (snapshot.connectionState == ConnectionState.done) {
        return Image.network(url);
      } else {
        return Container(color: Colors.grey[300]);
      }
    },
  );
}

Future<ImageProvider> getImageProvider(String url) async {
  ImageCacheManager cacheManager=ImageCacheManager();
  final file = await cacheManager.getImage(url);
  if (file != null) {
    return FileImage(file);
  } else {
    return NetworkImage(url);
  }
}