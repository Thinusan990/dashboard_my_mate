import 'dart:ui';

import 'package:flutter/material.dart';

class MyMateThemes {
  static const primaryColor = Color(0xFF555555);
  static const boyscolor = Color(0xFFB3DEE2);
  static const girlscolor = Color(0xFFC66582);
  static const textColor = Color(0xFF7C7C7C);
  static const backgroundColor = Color(0xFFFEFEFA);
  static const containerColor = Color(0xFFF3F2F2);
  static const activeusers = Color(0xFFA6D643);
  static const Color appbackgroundColor = Color(0xFFF5F5F7);
  static const Color boxColor = Color(0xFF3C3C3C);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  static final BoxDecoration boxDecoration = BoxDecoration(
    color: boxColor,
    borderRadius: BorderRadius.circular(4.0),
  );

  static final BoxDecoration centerBoxDecoration = BoxDecoration(
    color: boxColor,
    borderRadius: BorderRadius.circular(4.0),
  );

  static final BoxDecoration circularDecoration = BoxDecoration(
    color: whiteColor,
    shape: BoxShape.circle,
  );

  static final TextStyle textStyleSmallWhite = TextStyle(
    fontSize: 12,
    color: appbackgroundColor,
    fontFamily: 'Work Sans',
  );

  static final TextStyle textStyleExtraSmallWhite = TextStyle(
    fontSize: 10,
    color: whiteColor,
    fontFamily: 'Work Sans',
  );

  static final TextStyle textStyleBoldWhite = TextStyle(
    fontSize: 14,
    color: whiteColor,
    fontFamily: 'Work Sans',
    fontWeight: FontWeight.bold,
  );

  static final TextStyle textStyleBoldBlack = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: blackColor,
  );
}