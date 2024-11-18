import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatistics extends StatefulWidget {
  @override
  _UserStatisticsState createState() => _UserStatisticsState();
}

class _UserStatisticsState extends State<UserStatistics> {
  // Hardcoded data for the chart
  final Map<String, int> userTypeCounts = {
    'Active': 1879,
    'online': 273,
    'In Active': 521,
  };

  List<PieChartSectionData> _generateChartData() {
    final total = userTypeCounts.values.fold(0, (sum, count) => sum + count);
    return userTypeCounts.entries.map((entry) {
      final value = entry.value.toDouble();

      return PieChartSectionData(
        color: _getColorForUserType(entry.key),
        radius: 10,
        value: value,
        showTitle: false,
      );
    }).toList();
  }

  Color? _getColorForUserType(String userType) {
    switch (userType) {
      case 'Active':
        return Colors.grey[600];
      case 'online':
        return Colors.green[400];
      case 'In Active':
        return Colors.grey[400];

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total subscribers
    final total = userTypeCounts['In Active']! +
        userTypeCounts['Active']! +
        userTypeCounts['online']!;
    final totalUsers =
        userTypeCounts.values.fold(0, (sum, count) => sum + count);

    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          // Deduce container size

          return Container(
            width: 350,
            height: 240,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Donut Chart
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        sections: _generateChartData(),
                        centerSpaceRadius: 50,
                        sectionsSpace: 0,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${userTypeCounts['online']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${userTypeCounts['Active']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Active Users',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Total users',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
