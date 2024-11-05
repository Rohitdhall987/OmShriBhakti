import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget liveDarshanCard(){
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
              child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",BoxFit.fitHeight)
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
                Text("Tirupati balaji",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
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