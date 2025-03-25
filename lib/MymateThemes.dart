
import 'dart:ui';

import 'package:flutter/material.dart';

class Mymatethemes{
  static const Color backgroundColor = Color(0xFFFEFEFA);
  static const Color sidemenuColor = Color (0xFFF9FAFB);
  static const Color promotitleColor = Color(0xFFFFB743);
  static const Color textcolor = Color (0xFF666666);
  static const Color add_editbtn = Color(0xFF6F6F6F);
  static const Color standard = Color(0xFF34C759);
  static const Color premium = Color(0xFFFF3B30);
  static const Color basic = Color(0xFF707C8C);
 static const Color btns = Color(0xFFE6E6E6);
static  const commonbuttonclr = Color(0xFFFFFFFF);
  static const sidemenutextcolor =Color(0xFF7C7C7C);
  static const editabletextclr = Color(0xFF131117);

  static const double buttonFontSize = 16;
  static const double normalFontSize = 16 ;
  static const double subHeadFontSize = 18;
  static const double titlesize = 30;

}

class CommonButtonStyle {
  static ButtonStyle commonButtonStyle() {
    return
      ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Mymatethemes.add_editbtn),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            )),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0), // Adjust values as needed
        ),
      );
  }
}