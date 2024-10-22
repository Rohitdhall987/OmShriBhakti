import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

Widget menuItem(context,icon,name){
  return Container(
    padding:const  EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppTheme.backgroundLight,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.white24
      )
    ),
    child: Column(
      children: [
        Expanded(
            child: Icon(icon,
              size: MediaQuery.sizeOf(context).width*0.12,
              color: AppTheme.primary,
            )
        ),
        Text(name,
          style: TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis
          ),
        ),
      ],
    ),
  );
}