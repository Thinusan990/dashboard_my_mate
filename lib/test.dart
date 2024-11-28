import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Container(
            width: 422,
            height: 747,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30), // Top Padding

                // Navamsa Chart (Without Heading)
                NavamsaChart(),

                // Spacer between charts
                SizedBox(height: 30),

                // Rasi Chart (Without Heading)
                RasiChart(),

                // Spacer for labels
                Spacer(),

                // Place of Birth
                _buildLabelRow(
                  label: "Place of Birth :",
                  value: "Jaffna, Sri Lanka",
                  
                ),

                SizedBox(height: 16),

                // Time of Birth
                _buildLabelRow(
                  label: "Time of Birth :",
                  value: "11 : 45 PM",
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w200,
            color: Color(0xFF6F6F6F),
          ),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6F6F6F),
          ),
        ),
      ],
    );
  }
}

class NavamsaChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 258,
      height: 258,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          // Grid Background
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 16,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              if (index == 5 || index == 6 || index == 9 || index == 10) {
                return SizedBox.shrink(); // Skip for central area
              }
              return _buildGridItem(index + 1);
            },
          ),
          // Centered Decorative Chart
          Positioned(
            top: 66,
            left: 66,
            child: Container(
              width: 114,
              height: 114,
              decoration: BoxDecoration(
                color: Color(0xFF3C3C3C),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Navamsa Chart",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Image Widget
                  Stack(
                      alignment: Alignment.center, // Align images at the center
                      children: [
                    // Background Image (img2)
                      Image.asset(
                       'images/img2.png', // Replace with your image asset
                         width: 45,        // Adjust size as needed
                        height: 44.72,
                     ),
                    // Foreground Image (img1)
                  Positioned(
                    child: Image.asset(
                      'images/img1.png', // Replace with your image asset
                      width: 20,         // Size for img1
                      height: 20,
                      ),
                      ),
                      ],
                      ),
                  SizedBox(height: 4),
                  Text(
                    "Hastam",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Virgo (கன்னி)",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int number) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF3C3C3C),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            child: Text(
              number.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 4,
            bottom: 16,
            child: Text(
              "Ma",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 4,
            child: Text(
              "செவ்",
              style: TextStyle(
                fontSize: 4,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RasiChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 258,
      height: 258,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          // Grid Background
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 16,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              if (index == 5 || index == 6 || index == 9 || index == 10) {
                return SizedBox.shrink(); // Skip for central area
              }
              return _buildGridItem(index + 1);
            },
          ),
          // Centered Decorative Chart
          Positioned(
            top: 66,
            left: 66,
            child: Container(
              width: 114,
              height: 114,
              decoration: BoxDecoration(
                color: Color(0xFF3C3C3C),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rasi Chart",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                      alignment: Alignment.center, // Align images at the center
                      children: [
                    // Background Image (img2)
                      Image.asset(
                       'images/img2.png', // Replace with your image asset
                         width: 45,        // Adjust size as needed
                        height: 44.72,
                     ),
                    // Foreground Image (img1)
                  Positioned(
                    child: Image.asset(
                      'images/img1.png', // Replace with your image asset
                      width: 20,         // Size for img1
                      height: 20,
                      ),
                      ),
                      ],
                      ),
                  SizedBox(height: 4),
                  Text(
                    "Hastam",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Virgo (கன்னி)",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int number) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF3C3C3C),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            child: Text(
              number.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 4,
            bottom: 16,
            child: Text(
              "Ma",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 4,
            child: Text(
              "செவ்",
              style: TextStyle(
                fontSize: 4,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
