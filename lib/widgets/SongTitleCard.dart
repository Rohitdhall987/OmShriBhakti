import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

Widget songTitleCard({required BuildContext context,required int id, String? name,String? singer}){
  return Container(
    margin: const EdgeInsets.all(6),

    decoration: BoxDecoration(
      color: AppTheme.backgroundLight,
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(16)
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name ?? "Unknown",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              ),
              Text(singer ?? "Unknown",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),
              ),
            ],
          ),
          Icon(Icons.play_circle,color: Colors.white,size: MediaQuery.sizeOf(context).width*0.1,)
        ],
      ),
    ),
  );
}