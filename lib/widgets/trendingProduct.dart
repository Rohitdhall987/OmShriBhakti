import 'package:flutter/material.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget trendingProduct(image,title){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: cachedNetworkImage(image)
        ),
      ),
      Text(title,
        style: TextStyle(
          color: Colors.white
        ),
      )
    ],
  );
}