import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class multiplepichart extends StatefulWidget {
  @override
  _multiplepichartState createState() => _multiplepichartState();
}

class _multiplepichartState extends State<multiplepichart> {
  final Map<String, Map<String, int>> userTypeData = {
    'basic': {'boys': 60, 'girls': 55},
    'standard': {'boys': 50, 'girls': 45},
    'premium': {'boys': 40, 'girls': 38},
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Grey background
            borderRadius: BorderRadius.circular(16), // Rounded corners
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.all(12), // Padding for the container
          child: Row(
            mainAxisSize: MainAxisSize.min, // Ensures the row takes only the space needed by its children
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDonutChart(
                title: "Basic",
                boys: userTypeData['basic']!['boys']!,
                girls: userTypeData['basic']!['girls']!,
              ),
              SizedBox(width: 8), // Reduced gap between the charts
              _buildDonutChart(
                title: "Standard",
                boys: userTypeData['standard']!['boys']!,
                girls: userTypeData['standard']!['girls']!,
              ),
              SizedBox(width: 8), // Reduced gap between the charts
              _buildDonutChart(
                title: "Premium",
                boys: userTypeData['premium']!['boys']!,
                girls: userTypeData['premium']!['girls']!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonutChart({
    required String title,
    required int boys,
    required int girls,
  }) {
    final total = boys + girls;

    return Container(
      padding: EdgeInsets.all(8), // Padding for individual chart containers
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 120,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: boys.toDouble(),
                        color: Colors.lightBlue,
                        radius: 10,
                        title: '',
                      ),
                      PieChartSectionData(
                        value: girls.toDouble(),
                        color: Colors.pink,
                        radius: 10,
                        title: '',
                      ),
                    ],
                    centerSpaceRadius: 40,
                    sectionsSpace: 0,
                    borderData: FlBorderData(show: false),
                  ),
                ),
                Center(
                  child: Text(
                    '$total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
