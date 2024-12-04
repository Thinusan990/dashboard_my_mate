import 'package:dashboard_my_mate/MyMateThemes.dart';
import 'package:dashboard_my_mate/chart/navamsa_chart.dart';
import 'package:dashboard_my_mate/chart/raasi_chart.dart';
import 'package:flutter/material.dart';

class AstrologySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height; // Screen height from MediaQuery

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          SectionTitle("Astrology"),
          SizedBox(height: 5),

          // Decorative Line
          Row(
            children: [
              SizedBox(width: 42),
            ],
          ),
          SizedBox(height: 16),

          // Row of Astrology Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Info Card
              Container(
                height: screenHeight * 0.2, // Adjust height relative to screen height
                width: 140,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: MyMateThemes.containerColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child: Column(
                        children: [
                          Text(
                            '19 OCT 1998',
                            style: TextStyle(
                              fontSize: 12,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '10.30 AM',
                            style: TextStyle(
                              fontSize: 10,
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Jaffna, Sri Lanka',
                            style: TextStyle(
                              fontSize: 12,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),

              // Second Info Card
              Container(
                height: screenHeight * 0.2, // Adjust height relative to screen height
                width: 140,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 48,
                      child: Column(
                        children: [
                          Text(
                            'Hastam',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Virgo (kanni)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 40),

          // Center Content: Rasi and Navamsa Charts
          Center(
            child: Column(
              children: [
                RasiChartDesign(),
                SizedBox(height: 48),
                navamsaChartDesign(),
                SizedBox(height: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget SectionTitle(String title) {
  return Row(
    children: [
      SizedBox(width: 40),
      SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
