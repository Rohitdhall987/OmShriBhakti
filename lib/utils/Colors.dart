import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme{

  static const MaterialColor primary = MaterialColor(
    0xffFF2A03,
    <int, Color>{
      50: Color(0x3cFF2A03),
      100: Color(0x5fFF2A03),
      200: Color(0x88FF2A03),
      300: Color(0xa5FF2A03),
      400: Color(0xbdFF2A03),
      500: Color(0xffFF2A03),
      700: Color(0xffFF2A03),
      800: Color(0xffFF2A03),
      900: Color(0xffFF2A03),
    },
  );
  static const MaterialColor background = MaterialColor(
    0xff0c0c0c,
    <int, Color>{
      50: Color(0x3c0c0c0c),
      100: Color(0x5f0c0c0c),
      200: Color(0x880c0c0c),
      300: Color(0xa50c0c0c),
      400: Color(0xbd0c0c0c),
      500: Color(0xff0c0c0c),
      700: Color(0xff0c0c0c),
      800: Color(0xff0c0c0c),
      900: Color(0xff0c0c0c),
    },
  );

  static const MaterialColor backgroundLight = MaterialColor(
    0xff0c0c0c,
    <int, Color>{
      50: Color(0x3c262626),
      100: Color(0x5f262626),
      200: Color(0x88262626),
      300: Color(0xa5262626),
      400: Color(0xbd262626),
      500: Color(0xff262626),
      700: Color(0xff262626),
      800: Color(0xff262626),
      900: Color(0xff262626),
    },
  );


}