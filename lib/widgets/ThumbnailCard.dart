import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
Widget thumbnailCard(height,width,title,image){
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
              height: height,
              width: width,
              child: cachedNetworkImage(image,BoxFit.cover),
            // child: Image.network(image),
          ),

          Container(
            padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent,AppTheme.background.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(title,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                Icon(Icons.share,color: Colors.white,)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
