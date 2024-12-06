import 'package:flutter/material.dart';
import 'package:dashboard_my_mate/chart/combinedchart.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 55.0),  // Adjust padding as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,  // Align text to the left
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
          const SizedBox(width: 40), // Small space between label and value
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

void main() {
  runApp(MaterialApp(
    home: chart_complete(),
  ));
}
