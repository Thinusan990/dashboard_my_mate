import 'package:dashboard_my_mate/APIs/Userprofile.dart';
import 'package:dashboard_my_mate/MymateThemes.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Subscriberschart extends StatefulWidget {
  @override
  _SubscriberschartState createState() => _SubscriberschartState();
}

class _SubscriberschartState extends State<Subscriberschart> {
  Future<Map<String, int>> _getUserTypeCounts() async {
    try {
      final userProfileData = await fetchUserProfile();
      print('Fetched user profile data: $userProfileData');

      if (userProfileData == null || userProfileData.isEmpty) {
        print('No user data found!');
        return {
          'basic': 0,
          'standard': 0,
          'premium': 0,
          'unsubscribed': 0,
        };
      }

      Map<String, int> userTypeCounts = {
        'basic': 0,
        'standard': 0,
        'premium': 0,
        'unsubscribed': 0,
      };

      for (var user in userProfileData) {
        final userType = user['user_type'] ?? 'unsubscribed';
        print('User type: $userType');
        if (userTypeCounts.containsKey(userType)) {
          userTypeCounts[userType] = userTypeCounts[userType]! + 1;
        }
      }

      print('User type counts: $userTypeCounts');
      return userTypeCounts;
    } catch (e) {
      print('Error fetching user type counts: $e');
      return {
        'basic': 0,
        'standard': 0,
        'premium': 0,
        'unsubscribed': 0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: _getUserTypeCounts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final userTypeCounts = snapshot.data!;

        return buildChart(userTypeCounts);
      },
    );
  }

  List<PieChartSectionData> _generateChartData(Map<String, int> userTypeCounts) {
    final totalSubscribed = (userTypeCounts['basic'] ?? 0) +
        (userTypeCounts['standard'] ?? 0) +
        (userTypeCounts['premium'] ?? 0);
    final unsubscribed = userTypeCounts['unsubscribed'] ?? 0;

    return [
      PieChartSectionData(
        color: Colors.grey[600]!,
        value: totalSubscribed.toDouble(),
        radius: 10,
      ),
      PieChartSectionData(
        color: Colors.grey[400]!,
        value: unsubscribed.toDouble(),
        radius: 10,
      ),
    ];
  }

  Widget buildChart(Map<String, int> userTypeCounts) {
    final totalSubscribed = (userTypeCounts['basic'] ?? 0) +
        (userTypeCounts['standard'] ?? 0) +
        (userTypeCounts['premium'] ?? 0);
    final unsubscribed = userTypeCounts['unsubscribed'] ?? 0;

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
                            sections: _generateChartData(userTypeCounts),
                            centerSpaceRadius: 40,
                            sectionsSpace: 0,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${((totalSubscribed / (totalSubscribed + unsubscribed)) * 100).toStringAsFixed(0)}%',
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
                  SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatText(totalSubscribed, 'Subscribers'),
                      _buildStatText(
                          totalSubscribed + unsubscribed, 'Total Users'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox(
                      userTypeCounts['basic']!, totalSubscribed, Mymatethemes.basic),
                  _buildStatBox(userTypeCounts['standard']!, totalSubscribed,
                      Mymatethemes.standard),
                  _buildStatBox(
                      userTypeCounts['premium']!, totalSubscribed, Mymatethemes.premium),
                ],
              ),
              SizedBox(height: 20),

              _buildUserCountRow(
                  'Basic', userTypeCounts['basic']!, Mymatethemes.basic),
              _buildUserCountRow(
                  'Standard', userTypeCounts['standard']!, Mymatethemes.standard),
              _buildUserCountRow(
                  'Premium', userTypeCounts['premium']!, Mymatethemes.premium),
            ],
          ),
        ),
      ),
    );
  }

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
          '$count',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

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
