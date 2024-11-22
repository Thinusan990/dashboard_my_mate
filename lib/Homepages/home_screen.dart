import 'package:dashboard_my_mate/widgets/api_users.dart';
import 'package:dashboard_my_mate/widgets/calendar.dart';
import 'package:dashboard_my_mate/widgets/donut_chart.dart';
import 'package:dashboard_my_mate/widgets/fl_chart.dart';
import 'package:dashboard_my_mate/widgets/multiplepichart.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:dashboard_my_mate/widgets/userstatics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF555555),
                child: SidebarLayout(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey[600],
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.grey[600],
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
                            flex: 4,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: UserStatistics(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.grey[100],
                              child: Center(
                                child: multiplepichart(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // child: Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                       child: Container(

                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

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
                               child: Padding(
                               padding: const EdgeInsets.only(left: 10.0),

                                child: Container(
                                    width: 100,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      border: Border.all(
                                    color: Colors.grey,
                                      width: 1.5,

                                    ),
                                    ),
                                ),
                              ),
                            ),


                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: ApiUsers(),
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
