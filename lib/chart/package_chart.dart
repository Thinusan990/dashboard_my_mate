import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PackageChart(),
        ),
      ),
    );
  }
}

class PackageChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 422,
      height: 748,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE6E6E6), width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("Packages (3)"),
          const SizedBox(height: 16),
          _buildColoredRow("Stranded", "1", color: Color(0xFF34C759)),
          const SizedBox(height: 16),
          _buildColoredRow("Premium", "3", color: Color(0xFFFF3B30)),
          const SizedBox(height: 16),
          _buildColoredRow("Basic", "5", color: Color(0xFF707C8C)),
          const SizedBox(height: 52),
          _buildHeader("Boosts (2)"),
          const SizedBox(height: 16),
          _buildColoredRow("Boosted", "5", color: Color(0xFF0703F1)),
          const SizedBox(height: 16),
          _buildColoredRow("Super Boosted", "5", color: Color(0xFF0703F1)),
          const SizedBox(height: 52),
          _buildHeader("Promotions"),
          const SizedBox(height: 16),
          _buildColoredRow("Promo 1", "2", color: Color(0xFFFFB743)),
          const SizedBox(height: 16),
          _buildColoredRow("Promo 2", "1", color: Color(0xFFFFB743)),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF6F6F6F),
      ),
    );
  }

  Widget _buildColoredRow(String title, String count, {required Color color}) {
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
        ),
      ),
      Container(
        width: 60,
        height: 30, 
        alignment: Alignment.centerRight, // Align text to the right
        padding: const EdgeInsets.symmetric(horizontal: 12), // Inner padding
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(color: const Color(0xFFE6E6E6), width: 1), 
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Text(
          count,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.2,      // Line height adjustment
            color: Color(0xFF6F6F6F),
          ),
        ),
      ),
    ],
  );
}

}