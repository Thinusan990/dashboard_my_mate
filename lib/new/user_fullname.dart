import 'package:flutter/material.dart';

void main() {
  runApp(const UserFullNameWidget());
}
class User {
  final String name;
  final int age;
  final String dateOfBirth;
  final String occupation;
  final String address;
  final String education;
  final String height;
  final String religion;
  final String caste;
  final String mothersName;
  final String contact;
  final int noOfSiblings;

  User({
    required this.name,
    required this.age,
    required this.dateOfBirth,
    required this.occupation,
    required this.address,
    required this.education,
    required this.height,
    required this.religion,
    required this.caste,
    required this.mothersName,
    required this.contact,
    required this.noOfSiblings,
  });
}

final user = User(
  name: 'John Doe',
  age: 28,
  dateOfBirth: '1996-01-01',
  occupation: 'Software Engineer',
  address: '123 Main St, Anytown',
  education: 'B.Sc. Computer Science',
  height: '5\'10"',
  religion: 'Christianity',
  caste: 'General',
  mothersName: 'Jane Doe',
  contact: '+1234567890',
  noOfSiblings: 2,
);

class UserFullNameWidget extends StatelessWidget {
  const UserFullNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // First Column
              Flexible(
                flex: 1,
                child: Container(
                  width: 546,
                  height: 748,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE6E6E6),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow('Name', user.name),
                        _buildDivider(),
                        _buildRow('Age', '${user.age} years'),
                        _buildDivider(),
                        _buildRow('Date of Birth', user.dateOfBirth),
                        _buildDivider(),
                        _buildRow('Occupation', user.occupation),
                        _buildDivider(),
                        _buildRow('Address', user.address),
                        _buildDivider(),
                        _buildRow('Education', user.education),
                        _buildDivider(),
                        _buildRow('Height', user.height),
                        _buildDivider(),
                        _buildRow('Religion', user.religion),
                        _buildDivider(),
                        _buildRow('Caste', user.caste),
                        _buildDivider(),
                        _buildRow('Mother’s Name', user.mothersName),
                        _buildDivider(),
                        _buildRow('Contact No', user.contact),
                        _buildDivider(),
                        _buildRow('No of Siblings', '${user.noOfSiblings}'),
                      ],
                    ),
                  ),
                ),
              ),

              // Second Column (Integrating test.dart)
              Flexible(
                flex: 1,
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
                      const SizedBox(height: 30), // Top Padding

                      // Navamsa Chart (Without Heading)
                      NavamsaChart(),

                      // Spacer between charts
                      const SizedBox(height: 30),

                      // Rasi Chart (Without Heading)
                      RasiChart(),

                      // Spacer for labels
                      const Spacer(),

                      // Place of Birth
                      _buildLabelRow(
                        label: "Place of Birth :",
                        value: "Jaffna, Sri Lanka",
                      ),

                      const SizedBox(height: 16),

                      // Time of Birth
                      _buildLabelRow(
                        label: "Time of Birth :",
                        value: "11 : 45 PM",
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Third Column
              Flexible(
                flex: 1,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader("Packages (4)"),
                        const SizedBox(height: 16),
                        _buildColoredRow("Stranded", "17 Oct 2024", "11:59 PM",
                            color: const Color(0xFF34C759)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Premium", "17 Sep 2024", "11:59 PM",
                            color: Color(0xFFFF3B30)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Basic", "27 Aug 2024", "11:59 PM",
                            color: Color(0xFF707C8C)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Premium", "17 June 2024", "11:59 PM",
                            color: Color(0xFFFF3B30)),
                        const SizedBox(height: 32),
                        _buildHeader("Boosts (2)"),
                        const SizedBox(height: 16),
                        _buildColoredRow("Boosted", "17 Sep 2024", "11:59 PM",
                            color: Color(0xFF0703F1)),
                        const SizedBox(height: 16),
                        _buildColoredRow(
                            "Super Boosted", "17 June 2024", "11:59 PM",
                            color: Color(0xFF0703F1)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildRow(String title, String value) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              fontSize: 16,
              height: 1.19,
              color: Color(0xFF6F6F6F),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.19,
              color: Color(0xFF6F6F6F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFFE6E6E6),
      thickness: 1.0,
      height: 16,
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF6F6F6F),
      ),
    );
  }

  Widget _buildColoredRow(String title, String date, String time,
      {required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: color,
            letterSpacing: 0.1,
          ),
        ),
        Row(
          children: [
            Text(
              date,
              style: const TextStyle(
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF6F6F6F),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF6F6F6F),
              ),
            ),
          ],
        ),
      ],
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

// NavamsaChart and RasiChart components are reused from test.dart
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
              // Clockwise numbering for the grid excluding the center
              final List<int> clockwiseOrder = [
                1, 2, 3, 4,   // Top row
                12, 0, 0, 5,  // Left column, center, right column
                11, 0, 0, 6,  // Left column, center, right column
                10, 9, 8, 7   // Bottom row (reversed)
              ];
              final number = clockwiseOrder[index];

              // Skip central squares
              if (number == 0) {
                return SizedBox.shrink();
              }

              // Pass the number to _buildGridItem
              return _buildGridItem(number);
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
     // Define the numbers where the text should appear
  final List<int> highlightedNumbers = [1, 3, 6, 8, 10, 12];
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
           if (highlightedNumbers.contains(number)) ...[
          // Show the "Ma" and "செவ்" texts only for specified numbers
          Positioned(
            left: 4,
            bottom: 3,
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
            left: 22,
            bottom: 3,
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
              // Clockwise numbering for the grid excluding the center
              final List<int> clockwiseOrder = [
                1, 2, 3, 4,   // Top row
                12, 0, 0, 5,  // Left column, center, right column
                11, 0, 0, 6,  // Left column, center, right column
                10, 9, 8, 7   // Bottom row (reversed)
              ];
              final number = clockwiseOrder[index];

              // Skip central squares
              if (number == 0) {
                return SizedBox.shrink();
              }

              // Pass the number to _buildGridItem
              return _buildGridItem(number);
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
    // Define the numbers where the text should appear
    final List<int> highlightedNumbers = [1, 3, 6, 8, 10, 12];
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
          if (highlightedNumbers.contains(number)) ...[
          // Show the "Ma" and "செவ்" texts only for specified numbers
          Positioned(
            left: 4,
            bottom: 3,
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
            left: 22,
            bottom: 3,
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
        ],
      ),
    );
  }
}

