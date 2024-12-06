import 'package:dashboard_my_mate/MyMateThemes.dart';
import 'package:flutter/material.dart';

class NavamsaChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: MyMateThemes.backgroundColor, // Main container background color
            borderRadius: BorderRadius.circular(5), // Rounded corners
          ),
          child: Stack(
            children: [
              // Top row
              Positioned(top: 10, left: 10, child: individualBox("01")),
              Positioned(top: 10, left: 72, child: individualBox("02")),
              Positioned(top: 10, left: 134, child: individualBox("03")),
              Positioned(top: 10, left: 196, child: individualBox("04")),
              // Left column
              Positioned(top: 72, left: 10, child: individualBox("12")),
              Positioned(top: 134, left: 10, child: individualBox("11")),
              Positioned(top: 196, left: 10, child: individualBox("10")),
              // Right column
              Positioned(top: 72, left: 196, child: individualBox("05")),
              Positioned(top: 134, left: 196, child: individualBox("06")),
              Positioned(top: 196, left: 196, child: individualBox("07")),
              // Bottom row
              Positioned(top: 196, left: 134, child: individualBox("08")),
              Positioned(top: 196, left: 72, child: individualBox("09")),
              // Center container
              Positioned(
                top: 72,
                left: 72,
                child: Container(
                  height: 114,
                  width: 114,
                  decoration: MyMateThemes.centerBoxDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Navamsa Chart',
                        style: MyMateThemes.textStyleSmallWhite,
                      ),
                      SizedBox(height: 8),
                      // Placeholder for the circular graphic
                      Container(
                        height: 40,
                        width: 40,
                        decoration: MyMateThemes.circularDecoration,
                        child: Center(
                          child: Text(
                            'Icon', // Replace with actual graphic
                            style: MyMateThemes.textStyleBoldBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hastam',
                        style: MyMateThemes.textStyleBoldWhite,
                      ),
                      Text(
                        'Virgo (கன்னி)',
                        style: MyMateThemes.textStyleSmallWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget individualBox(String number) {
    return Container(
      height: 52, // Matches the height in CSS
      width: 52, // Matches the width in CSS
      decoration: MyMateThemes.boxDecoration,
      child: Stack(
        children: [
          // Number "01"
          Positioned(
            top: 1, // Matches top: 1px
            right: 2, // Aligns with CSS's `text-align: right`
            child: Text(
              number,
              style: MyMateThemes.textStyleExtraSmallWhite.copyWith(
                fontSize: 6, // Matches font-size: 6px
                height: 7 / 6, // Matches line-height to font-size ratio
                fontWeight: FontWeight.w600, // Matches font-weight: 600
              ),
            ),
          ),
          // English Text "Ma"
          if (["01", "03", "06", "10", "12"].contains(number)) ...[
            Positioned(
              left: 2, // Matches left: 2px
              bottom: 3, // Adjusted to match `top: 37px`
              child: Text(
                "Ma",
                style: MyMateThemes.textStyleSmallWhite.copyWith(
                  fontSize: 12, // Matches font-size: 12px
                  height: 14 / 12, // Matches line-height: 14px
                ),
              ),
            ),
            Positioned(
              left: 20, // Matches left: 20px
              bottom: 3, // Adjusted to match `top: 44px`
              child: Text(
                "செவ்",
                style: MyMateThemes.textStyleExtraSmallWhite.copyWith(
                  fontSize: 4, // Matches font-size: 4px
                  height: 5 / 4, // Matches line-height to font-size ratio
                ),
              ),
            ),
          ],
        ],),
    );
  }
}

