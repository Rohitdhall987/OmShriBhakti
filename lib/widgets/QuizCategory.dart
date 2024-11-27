import 'package:flutter/material.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

Widget quizCategory(title,image){
  return themeContainer(child: Column(
    children: [
      Expanded(child: cachedNetworkImage(image, BoxFit.cover)),
      Text(title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    ],
  ));
}