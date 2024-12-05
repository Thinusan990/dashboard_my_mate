import 'package:flutter/material.dart';

class MyMateThemes {
  static const Color backgroundColor = Color(0xFFF5F5F7);
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
    color: backgroundColor,
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
