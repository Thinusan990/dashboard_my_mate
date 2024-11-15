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
            // Sidebar section
            Expanded(
              flex: 2, // Adjusted flex for the sidebar width
              child: Container(
                color: Color(0xFF555555),
                child: SidebarLayout(), // Sidebar widget
              ),
            ),

            Expanded(
              flex: 7,
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
                                    child: fl_chart(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
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
                        color: Colors.green[100], // Graph 2 container
                        child: Center(),
                      ),
                    ),

                    // Third graph section
                    Expanded(
                      flex: 1, // 1/3 of the remaining height
                      child: Container(
                        color: Colors.orange[100], // Graph 3 container
                        child: Center(),
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
