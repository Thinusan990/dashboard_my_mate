import 'package:dashboard_my_mate/widgets/calendar.dart';
import 'package:dashboard_my_mate/widgets/donut_chart.dart';
import 'package:dashboard_my_mate/widgets/fl_chart.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Color(0xFF555555),
                child: SidebarLayout(),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: fl_chart(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.grey[100],
                              child: Center(
                                child: DonutChart(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.green[100],
                        child: Center(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.white,
                                child: Calendar(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.blue[100],
                                child: Center(
                                  child: Text('Column 1',
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                            ),
                            // Third column (empty placeholder)
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.orange[100], // Placeholder color
                                child: Center(
                                  child: Text('Column 3',
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
