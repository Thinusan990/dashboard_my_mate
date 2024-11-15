import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class fl_chart extends StatefulWidget {
  @override
  _fl_chart createState() => _fl_chart();
}

class _fl_chart extends State<fl_chart> {
  List<BarChartGroupData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _fetchLoginData();
  }

  Future<void> _fetchLoginData() async {
    // final loginData = await FirebaseFirestore.instance.collection('clients').get();

    Map<String, int> boysData = {
      'Mon': 20,
      'Tue': 20,
      'Wed': 16,
      'Thu': 19,
      'Fri': 7,
      'Sat': 15,
      'Sun': 37,
    };
    Map<String, int> girlsData = {
      'Mon': 30,
      'Tue': 12,
      'Wed': 16,
      'Thu': 19,
      'Fri': 24,
      'Sat': 11,
      'Sun': 35,
    };

    /*
    for (var doc in loginData.docs) {
      var day = doc['day'];
      var gender = doc['gender'];
      var count = (doc['login_count'] as num).toInt();

      if (gender == 'boy') {
        boysData[day] = (boysData[day] ?? 0) + count;
      } else if (gender == 'girl') {
        girlsData[day] = (girlsData[day] ?? 0) + count;
      }
    }
    */

    setState(() {
      _chartData = List.generate(7, (index) {
        final day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index];
        return BarChartGroupData(
          x: index,
          barsSpace: 1,
          barRods: [
            BarChartRodData(
              toY: (boysData[day]?.toDouble() ?? 0),
              color: Colors.blue.withOpacity(0.7),
              width: 8, // Width of the boys' bar
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: (girlsData[day]?.toDouble() ?? 0),
              color: Colors.pink.withOpacity(0.7),
              width: 8, // Width of the girls' bar
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'new user',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 150,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 40,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        reservedSize: 100,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          return Text(days[value.toInt()],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12));
                        },
                      ),
                    ),
                  ),
                  barGroups: _chartData,
                  borderData: FlBorderData(
                    show: false,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
