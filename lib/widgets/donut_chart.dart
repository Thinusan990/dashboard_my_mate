import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonutChart extends StatefulWidget {
  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  Map<String, int> userTypeCounts = {};

  @override
  void initState() {
    super.initState();
    _fetchUserTypeData();
  }

  Future<void> _fetchUserTypeData() async {
    final snapshot = await FirebaseFirestore.instance.collection('clients').get();

    Map<String, int> counts = {};
    for (var doc in snapshot.docs) {
      String userType = doc['user type'];
      counts[userType] = (counts[userType] ?? 0) + 1;
    }

    setState(() {
      userTypeCounts = counts;
    });
  }

  List<PieChartSectionData> _generateChartData() {
    final total = userTypeCounts.values.fold(0, (sum, count) => sum + count);
    return userTypeCounts.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(

        color: _getColorForUserType(entry.key),

        radius: 8,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getColorForUserType(String userType) {
    // Define colors for each user type
    switch (userType) {
      case 'basic':
        return Color(0xFF5D5858);
      case 'standard':
        return Color(0x3B3A3AFF);
      case 'premium':
        return Color(0x1FF181718);
      default:
        return Color(0x424040FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: userTypeCounts.isNotEmpty
              ? PieChart(
            PieChartData(
              sections: _generateChartData(),
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {

                },
              ),
            ),
          )
              : CircularProgressIndicator(), // Show a loader until data is available
        ),
      ),
    );
  }
}
