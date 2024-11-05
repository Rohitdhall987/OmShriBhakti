import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/utils/format.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

Widget articleCard({
  required String type,
  double? height,
  double? width,
  required List<String> images,
  required int seriesCount,
  required int singleCount,
  required String date,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white
    ),
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: cachedNetworkImage(images[index],BoxFit.fitHeight),


                );
              },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(singleCount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(" Single $type"),
            const Expanded(child: SizedBox()),
            Text(seriesCount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(" $type Series"),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDate(date),
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
            ),

            Text("View All",
              style: TextStyle(
                color: AppTheme.primary
              ),
            )
          ],
        )
      ],
    ) ,
  );


}
