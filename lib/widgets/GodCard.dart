import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget godCard ({required String name ,required String image}){
  return Container(
    padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.backgroundLight
      ),
      child: Column(
        children: [
          Expanded(child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: cachedNetworkImage(image, BoxFit.cover))
          ),
          SizedBox(
            height: 8,
          ),
          Text(name,style:const TextStyle(color: Colors.white),)
        ],
      )
  );
}