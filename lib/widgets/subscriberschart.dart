import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class subscriberschart extends StatefulWidget {
  @override
  _subscriberschart createState() => _subscriberschart();
}

class _subscriberschart extends State<subscriberschart> {
  Map<String, int> userTypeCounts = {
    'basic': 0,
    'standard': 0,
    'premium': 0,
    'unsubscribed': 0,
  };

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore.collection('clients').get();

    Map<String, int> tempCounts = {
      'basic': 0,
      'standard': 0,
      'premium': 0,
      'unsubscribed': 0,
    };

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final userType = data['user type'] ?? 'unsubscribed';

      if (tempCounts.containsKey(userType)) {
        tempCounts[userType] = tempCounts[userType]! + 1;
      }
    }

    setState(() {
      userTypeCounts = tempCounts;
    });
  }

  List<PieChartSectionData> _generateChartData() {
    final totalSubscribed = userTypeCounts['basic']! +
        userTypeCounts['standard']! +
        userTypeCounts['premium']!;
    final unsubscribed = userTypeCounts['unsubscribed']!;

    return [
      PieChartSectionData(
        color: Colors.grey[600],
        value: totalSubscribed.toDouble(),
        radius: 10,
      ),
      PieChartSectionData(
        color: Colors.grey[400],
        value: unsubscribed.toDouble(),
        radius: 10,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final totalSubscribed = userTypeCounts['basic']! +
        userTypeCounts['standard']! +
        userTypeCounts['premium']!;
    final totalUsers = totalSubscribed + userTypeCounts['unsubscribed']!;

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 850,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // First Row: Pie Chart
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sections: _generateChartData(),
                            centerSpaceRadius: 40,
                            sectionsSpace: 0,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${((totalSubscribed / totalUsers) * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8), // Space between pie chart and text
                  // Total Subscribers and Total Users Text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatText(totalSubscribed, 'Subscribers'),
                      _buildStatText(totalUsers, 'Total '),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Percentages for Basic, Standard, and Premium
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox(
                      userTypeCounts['basic']!, totalSubscribed, Colors.blue),
                  _buildStatBox(userTypeCounts['standard']!, totalSubscribed,
                      Colors.green),
                  _buildStatBox(
                      userTypeCounts['premium']!, totalSubscribed, Colors.red),
                ],
              ),

              SizedBox(height: 20),

              // Counts for each category
              _buildUserCountRow(
                  'Basic', userTypeCounts['basic']!, Colors.blue),
              _buildUserCountRow(
                  'Standard', userTypeCounts['standard']!, Colors.green),
              _buildUserCountRow(
                  'Premium', userTypeCounts['premium']!, Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for stat boxes
  Widget _buildStatBox(int count, int total, Color color) {
    final percentage = total > 0 ? (count / total) * 100 : 0;
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildStatText(int count, String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 4),
        Text(
          '$count',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  // Helper function for user count rows
  Widget _buildUserCountRow(String title, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            '$count Users',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
