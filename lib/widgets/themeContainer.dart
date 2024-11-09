import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

Widget themeContainer({required Widget child}){
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppTheme.backgroundLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white24)
    ),
    child: child,
  );
}
