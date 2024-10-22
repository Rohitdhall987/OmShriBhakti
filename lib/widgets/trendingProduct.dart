import 'package:flutter/material.dart';

Widget trendingProduct(image,title){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.network(image,fit: BoxFit.fitHeight,)
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