import 'package:flutter/material.dart';

void main() {
  runApp(const UserpackageWidget());
}

class UserpackageWidget extends StatelessWidget {
  const UserpackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double width = MediaQuery.of(context).size.width;

    // Adjust the container size based on the screen width
    double containerWidth = width > 600 ? 422 : width * 0.9;
    double containerHeight = width > 600 ? 748 : width * 0.7;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container holding the content
              Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFE6E6E6),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: SingleChildScrollView( // Makes the content scrollable on smaller screens
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader("Packages (4)"),
                        const SizedBox(height: 16),
                        _buildColoredRow("Stranded", "17 Oct 2024", "11:59 PM", color: const Color(0xFF34C759)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Premium", "17 Sep 2024", "11:59 PM", color: const Color(0xFFFF3B30)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Basic", "27 Aug 2024", "11:59 PM", color: const Color(0xFF707C8C)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Premium", "17 June 2024", "11:59 PM", color: const Color(0xFFFF3B30)),
                        const SizedBox(height: 60),
                        _buildHeader("Boosts (2)"),
                        const SizedBox(height: 16),
                        _buildColoredRow("Boosted", "17 Sep 2024", "11:59 PM", color: const Color(0xFF0703F1)),
                        const SizedBox(height: 16),
                        _buildColoredRow("Super Boosted", "17 June 2024", "11:59 PM", color: const Color(0xFF0703F1)),
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

  // Helper method to build header text
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

  // Helper method to build colored rows with title, date, and time
  Widget _buildColoredRow(String title, String date, String time, {required Color color}) {
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
}
