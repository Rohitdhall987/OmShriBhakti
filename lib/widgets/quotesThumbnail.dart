import 'package:flutter/material.dart';

Widget quotesThumbnail(context,String image,title,subTitle){
  double width=MediaQuery.sizeOf(context).width*0.275;
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        width: width,
        height: MediaQuery.sizeOf(context).height*0.17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:const Color(0xffC0A30B)
                )
              ),
              height: MediaQuery.sizeOf(context).height*0.15,

            ),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height*0.17,
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height*0.12,
              width: width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fitHeight,),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1,1),
                    spreadRadius: 0,
                    blurRadius: 4
                  )
                ]
              ),
            ),

            Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subTitle,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12
              ),
            ),

          ],
        ),
      )
    ],
  );
}