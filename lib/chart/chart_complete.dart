import 'package:flutter/material.dart';
import 'package:dashboard_my_mate/MyMateThemes.dart';

class chart_complete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 422,
          height: 748,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE6E6E6),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10), // Top Padding

              // Integrated CombinedChart
              Expanded(
                child: CombinedChart(),
              ),

              // Place of Birth and Time of Birth
              const SizedBox(height: 5),

              _buildLabelRow(
                label: "Place of Birth :",
                value: "Jaffna, Sri Lanka",
              ),
              const SizedBox(width: 10),

              _buildLabelRow(
                label: "Time of Birth :",
                value: "11 : 45 PM",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating rows
  Widget _buildLabelRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0), // Adjust padding as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align text to the left
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6F6F6F),
            ),
          ),
          const SizedBox(width: 50), // Small space between label and value
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6F6F6F),
            ),
          ),
        ],
      ),
    );
  }
}

class CombinedChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavamsaChart(), // The first chart
        SizedBox(height: 20), // Space between the two charts
        RasiChart(), // The second chart
      ],
    );
  }
}

class NavamsaChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return chartWidget('Navamsa Chart');
  }
}

class RasiChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return chartWidget('Rasi Chart');
  }
}

// Common chart widget to reduce redundancy
Widget chartWidget(String chartTitle) {
  return Container(
    height: 258,
    width: 258,
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
                  chartTitle,
                  style: MyMateThemes.textStyleSmallWhite,
                ),
                SizedBox(height: 8),
                // Placeholder for the circular graphic
                Container(
                  height: 40, // Height based on your image size
                  width: 40, // Width based on your image size
                  child: Stack(
                    children: [
                      // First image (img1)
                      Positioned(
                        child: Image.asset(
                          'images/img2.png', // Use the relative path as per your assets folder
                          height: 40, // Match image height
                          width: 40, // Match image width
                          fit: BoxFit.cover, // Adjust as needed to fit the container
                        ),
                      ),
                      // Second image (img2)
                      Positioned(
                        left: 15, // Adjust as per your requirement
                        top: 15, // Adjust as per your requirement
                        child: Image.asset(
                          'images/img1.png', // Use the relative path as per your assets folder
                          height: 10, // Match image height
                          width: 10, // Match image width
                          fit: BoxFit.cover, // Adjust as needed to fit the container
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget individualBox(String number) {
  return Container(
    height: 52,
    width: 52,
    decoration: MyMateThemes.boxDecoration,
    child: Stack(
      children: [
        // Number part
        Positioned(
          top: 1,
          right: 2,
          child: numberWidget(number),
        ),
        // Text part
        if (["01", "03", "06", "10", "12"].contains(number))
          Positioned(
            left: 2,
            bottom: 3,
            child: rowTextWidget("Ma", "செவ்"),
          ),
        // Special case for the 8th box with 3 rows of "Ma செவ்"
        if (number == "08")
          Positioned(
            top: 10,
            left: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) => rowTextWidget("Ma", "செவ்"),
              ),
            ),
          ),
      ],
    ),
  );
}

// Helper widget for the number
Widget numberWidget(String number) {
  return Text(
    number,
    style: MyMateThemes.textStyleExtraSmallWhite.copyWith(
      fontSize: 6,
      height: 7 / 6,
      fontWeight: FontWeight.w600,
    ),
  );
}

// Helper widget for the row of "Ma செவ்"
Widget rowTextWidget(String englishText, String tamilText) {
  return Row(
    children: [
      Text(
        englishText,
        style: MyMateThemes.textStyleSmallWhite.copyWith(
          fontSize: 12,
          height: 14 / 12,
        ),
      ),
      SizedBox(width: 3), // Space between "Ma" and "செவ்"
      Text(
        tamilText,
        style: MyMateThemes.textStyleExtraSmallWhite.copyWith(
          fontSize: 4,
          height: 5 / 4,
        ),
      ),
    ],
  );
}

void main() {
  runApp(MaterialApp(
    home: chart_complete(),
  ));
}
