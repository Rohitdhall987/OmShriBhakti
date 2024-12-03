import 'package:flutter/material.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget trendingProduct(image,title){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(00),
            child: cachedNetworkImage(image,BoxFit.fitHeight)
        ),
      ),
      Text(title,
        style: const TextStyle(
          color: Colors.white,
          overflow: TextOverflow.ellipsis
        ),
      )
    ],
  );
}