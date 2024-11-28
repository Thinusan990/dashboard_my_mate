import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                        _buildRow('Age', '26 years'),
                        _buildDivider(),
                        _buildRow('Date of birth', '1998 October 29'),
                        _buildDivider(),
                        _buildRow('Occupation', 'Doctor'),
                        _buildDivider(),
                        _buildRow('Address', 'Jaffna'),
                        _buildDivider(),
                        _buildRow(
                            'Education', 'BSc Computer Science, MSc Applied Mathematics'),
                        _buildDivider(),
                        _buildRow('Height', '163 CM'),
                        _buildDivider(),
                        _buildRow('Religion', 'Hindu'),
                        _buildDivider(),
                        _buildRow('Caste', 'Optional'),
                        _buildDivider(),
                        _buildRow('Mother’s name', 'B.Suganthini'),
                        _buildDivider(),
                        _buildRow('Contact No', '0761692028'),
                        _buildDivider(),
                        _buildRow('No of Siblings', '2'),
                      ],
                    ),
                  ),
                ),
              ),

              // Second Column Placeholder
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
                  child: Center(
                    child: const Text(
                      "Second Column Placeholder",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6F6F6F),
                      ),
                    ),
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

  // First Column Helpers
  Widget _buildRow(String title, String value) {
    return SizedBox(
      height: 46,
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

  // Third Column Helpers
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
}
