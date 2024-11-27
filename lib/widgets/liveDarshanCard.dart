import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget liveDarshanCard({required String image,required String title}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SizedBox(
            height: double.maxFinite,
              child: cachedNetworkImage(image,BoxFit.fitHeight)
          )),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text("Temple",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 10
                    ),
                  ),
                ),
                Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    overflow: TextOverflow.ellipsis
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.play_arrow_rounded,color: Colors.white,),
          )
        ],
      ),
    ),
  );
}