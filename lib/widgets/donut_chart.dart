import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonutChart extends StatefulWidget {
  final bool showPercentage;

  DonutChart({this.showPercentage = true});

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  // User type data
  final Map<String, int> userTypeCounts = {
    'basic': 50,
    'standard': 30,
    'premium': 20,
    'unsubscribed': 40,
  };

  // Generate pie chart data
  List<PieChartSectionData> _generateChartData() {
    final total = userTypeCounts.values.fold(0, (sum, count) => sum + count);

    return userTypeCounts.entries.map((entry) {
      final value = entry.value.toDouble();
      return PieChartSectionData(
        color: _getColorForUserType(entry.key),
        value: value,
        radius: 10,
        showTitle: false,
      );
    }).toList();
  }

  // Get colors for each user type
  Color? _getColorForUserType(String userType) {
    switch (userType) {
      case 'basic':
        return Colors.grey[400];
      case 'standard':
        return Colors.grey[600];
      case 'premium':
        return Colors.grey[900];
      case 'unsubscribed':
        return Colors.grey[300];
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total subscribers
    final totalSubscribers = userTypeCounts['basic']! +
        userTypeCounts['standard']! +
        userTypeCounts['premium']!;
    final totalUsers = userTypeCounts.values.fold(0, (sum, count) => sum + count);
    final subscribedPercentage = (totalSubscribers / totalUsers) * 100;

    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Deduce container size


            return Container(
              width: 350,
              height: 200,
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
                    alignment: Alignment.centerRight,
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

                  // Percentage in the center of the graph
                  if (widget.showPercentage)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Center(
                        child: Text(
                          '${subscribedPercentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Subscribers text (Aligned similar to the graph)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalSubscribers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Subscribers',
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
          }
    ),
    ),
    );
  }
  }
