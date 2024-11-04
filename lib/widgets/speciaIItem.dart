
import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget specialItem(image,title,subTitle){
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.backgroundLight,
      border: Border.all(
          color: Colors.white24
      )
    ),
    child: Row(
      children: [
        Expanded(
          flex: 4,
            child: cachedNetworkImage(image,
            )
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),
                ),
                Text(subTitle,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 10
                  ),
                ),
              ],
            )
        )
      ],
    ),
  );
}