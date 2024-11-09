import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

Widget geetaCard(adhyayaData){
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.backgroundLight,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white24)
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adhyaya ${adhyayaData["adhyaya"]}',
            style: TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Shlokas ${adhyayaData["shloka_count"]}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}