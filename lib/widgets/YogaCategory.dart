import 'package:flutter/material.dart';
import 'package:omshribhakti/model/yoga_category_model.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget yogaCategoryCard({required double height,required double width,required AllYogaCategories category}){
  return Container(
    height: height,
    width: width,
    padding:const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width*0.3,
            child: cachedNetworkImage(category.image, BoxFit.fitHeight)
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            const Text("NO DESCRIPTION",
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ],
        )
      ],
    ),
  );
}