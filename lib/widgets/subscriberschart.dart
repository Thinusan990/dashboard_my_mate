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
        final userType = (user['user_type'] ?? 'unsubscribed').toString().toLowerCase();
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
        title: '', // Remove text from slice
      ),
      PieChartSectionData(
        color: Colors.grey[400]!,
        value: unsubscribed.toDouble(),
        radius: 10,
        title: '', // Remove text from slice
      ),
    ];
  }

  Widget buildChart(Map<String, int> userTypeCounts) {
    final totalSubscribed = (userTypeCounts['basic'] ?? 0) +
        (userTypeCounts['standard'] ?? 0) +
        (userTypeCounts['premium'] ?? 0);
    final unsubscribed = userTypeCounts['unsubscribed'] ?? 0;

    return LayoutBuilder(
        builder: (context, constraints) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Scaffold(
            body: Center(
              child: Container(
                width: width * 0.22,
                height: height * 0.8,
                padding: EdgeInsets.all(width * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.01),
                  border: Border.all(
                    color: Mymatethemes.add_editbtn.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.1,
                          height: height * 0.1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sections: _generateChartData(userTypeCounts),
                                  centerSpaceRadius: 35,
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
                                      fontSize: width * 0.014,
                                      fontWeight: FontWeight.w600,
                                      color: Mymatethemes.textcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatText(totalSubscribed, 'Subscribers'),
                            SizedBox(height: height * 0.05),
                            _buildStatText(totalSubscribed + unsubscribed, 'Total'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatBox(userTypeCounts['basic']!, totalSubscribed, Mymatethemes.basic),
                        _buildStatBox(userTypeCounts['standard']!, totalSubscribed, Mymatethemes.standard),
                        _buildStatBox(userTypeCounts['premium']!, totalSubscribed, Mymatethemes.premium),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        _buildUserBasicCountRow('Basic', userTypeCounts['basic']!, Mymatethemes.basic),
                      ],
                    ),
                    _buildUserCountRow('Standard', userTypeCounts['standard']!, Mymatethemes.standard),
                    _buildUserCountRow('Premium', userTypeCounts['premium']!, Mymatethemes.premium),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildStatBox(int count, int total, Color color) {
    final percentage = total > 0 ? (count / total) * 100 : 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.06,
      height: height * 0.062,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
                fontSize: width * 0.01, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildStatText(int count, String title) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
              fontSize: width * 0.012, fontWeight: FontWeight.w600, color: Mymatethemes.sidemenutextcolor),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: width * 0.011,
              color: Mymatethemes.sidemenutextcolor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.8),
        ),
      ],
    );
  }

  Widget _buildUserCountRow(String title, int count, Color color) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: width * 0.03),
          Text(
            title,
            style: TextStyle(
                fontSize: width * 0.011,
                fontWeight: FontWeight.w100,
                color: color),
          ),
          SizedBox(width: width * 0.05),
          Text(
            '$count',
            style: TextStyle(fontSize: width * 0.012, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildUserBasicCountRow(String title, int count, Color color) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: width * 0.03),
          Text(
            title,
            style: TextStyle(
                fontSize: width * 0.011,
                fontWeight: FontWeight.w100,
                color: color),
          ),
          SizedBox(width: width * 0.068),
          Text(
            '$count',
            style: TextStyle(fontSize: width * 0.012, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
