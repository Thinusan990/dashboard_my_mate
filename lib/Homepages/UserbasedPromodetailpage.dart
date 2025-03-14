import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserbasedPromodetailpage extends StatefulWidget {
  @override
  _UserbasedPromodetailpageState createState() => _UserbasedPromodetailpageState();
}

class _UserbasedPromodetailpageState extends State<UserbasedPromodetailpage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SidebarLayout(),
            ),
            Expanded(

              flex: 8,
              child:Container(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              Container(
                                height: 20,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  'Promo 1',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () { },
                                child: Text('Expired'),
                              )
                            ]
                        ),

                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 1.0),
                              bottom: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.tune),
                                    label: Text('Customize'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.settings),
                                    label: Text('Settings'),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 4, height: 5),
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: (value) {
                                        setState(() {
                                          searchQuery = value.toLowerCase();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(16.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Action Row
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                label: Text('Add New User'),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5),

                        // Button Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Select all'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Delete'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Add To'),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Main Content Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 3,
                              child: UserTableWidget(),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              flex: 7,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: _buildsplpromocard(
                                         totalusers: 100,
                                          remainingusers: 33,
                                            priceWorldWide: '10 \$',
                                            priceLocal: '3000 LKR',
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Flexible(
                                        flex: 4,
                                        child: _promouserchart(
                                            percentage: 67,
                                            subscribers: 267,
                                            title: 'promo 1'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    child: promographWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserTableWidget extends StatefulWidget {
  @override
  _UserTableWidgetState createState() => _UserTableWidgetState();
}

class _UserTableWidgetState extends State<UserTableWidget> {
  int _currentPage = 0;
  final int _rowsPerPage = 11;

  final List<Map<String, dynamic>> _data = [
    {'username': '@User Name 1', 'days': '01', 'hrs': '12', 'mins': '30', 'checked': false},
    {'username': '@User Name 2', 'days': '02', 'hrs': '10', 'mins': '45', 'checked': false},
    {'username': '@User Name 3', 'days': '03', 'hrs': '09', 'mins': '10', 'checked': false},
    {'username': '@User Name 4', 'days': '04', 'hrs': '08', 'mins': '50', 'checked': false},
    {'username': '@User Name 5', 'days': '05', 'hrs': '06', 'mins': '20', 'checked': false},
    {'username': '@User Name 6', 'days': '06', 'hrs': '15', 'mins': '30', 'checked': false},
    {'username': '@User Name 7', 'days': '07', 'hrs': '05', 'mins': '25', 'checked': false},
    {'username': '@User Name 8', 'days': '08', 'hrs': '18', 'mins': '10', 'checked': false},
    {'username': '@User Name 9', 'days': '09', 'hrs': '20', 'mins': '05', 'checked': false},
    {'username': '@User Name 10', 'days': '10', 'hrs': '02', 'mins': '30', 'checked': false},
    {'username': '@User Name 11', 'days': '11', 'hrs': '22', 'mins': '15', 'checked': false},
    {'username': '@User Name 12', 'days': '12', 'hrs': '10', 'mins': '45', 'checked': false},
    {'username': '@User Name 13', 'days': '13', 'hrs': '13', 'mins': '50', 'checked': false},
    {'username': '@User Name 14', 'days': '14', 'hrs': '07', 'mins': '10', 'checked': false},
    {'username': '@User Name 15', 'days': '15', 'hrs': '12', 'mins': '05', 'checked': false},
    {'username': '@User Name 16', 'days': '16', 'hrs': '14', 'mins': '30', 'checked': false},
    {'username': '@User Name 17', 'days': '17', 'hrs': '09', 'mins': '50', 'checked': false},
    {'username': '@User Name 18', 'days': '18', 'hrs': '08', 'mins': '40', 'checked': false},
    {'username': '@User Name 19', 'days': '19', 'hrs': '11', 'mins': '10', 'checked': false},
    {'username': '@User Name 20', 'days': '20', 'hrs': '05', 'mins': '30', 'checked': false},
  ];

  @override
  Widget build(BuildContext context) {
    final start = _currentPage * _rowsPerPage;
    final end = (_currentPage + 1) * _rowsPerPage;
    final visibleRows = _data.sublist(start, end > _data.length ? _data.length : end);

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DataTable(
                columnSpacing: 20,
                headingRowHeight: 70,
                dataRowHeight: 50,
                headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Username',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Time Remaining',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Days',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text('Hrs',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text('Mins',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
                rows: visibleRows.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            Checkbox(
                              value: data['checked'],
                              onChanged: (bool? value) {
                                setState(() {
                                  data['checked'] = value!;
                                });
                              },
                            ),
                            Text(data['username']),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(data['days'], style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(data['hrs'], style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(data['mins'], style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _currentPage > 0
                    ? () {
                  setState(() {
                    _currentPage--;
                  });
                }
                    : null,
              ),
              SizedBox(width: 8),
              Text('Page ${_currentPage + 1} of ${(_data.length / _rowsPerPage).ceil()}'),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (_currentPage + 1) * _rowsPerPage < _data.length
                    ? () {
                  setState(() {
                    _currentPage++;
                  });
                }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildsplpromocard({
  required int totalusers,
  required int remainingusers,
  required String priceWorldWide,
  required String priceLocal,
}) {
  return Stack(children: [
    Container(
        width: 350,
        height: 350,
        margin: const EdgeInsets.only(top: 0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 8,
            width: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Users',
                style: TextStyle(fontSize: 14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(totalusers.toString(), ''),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining Users',
                style: TextStyle(fontSize: 14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(remainingusers.toString(), ''),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(fontSize: 14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(priceWorldWide.toString(), 'WorldWide'),
                  _buildPriceBox(priceLocal.toString(), 'In Srilanka'),
                ],
              )
            ],
          ),

          SizedBox(height: 6),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit'),
            ),
          ])
        ]))
  ]);
}

Widget _buildPriceBox(String value, String label) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    ],
  );
}

Widget _promouserchart({
  required int percentage,
  required int subscribers,
  required String title,
}) {
  return Container(
    width: 400,
    height: 350,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: percentage / 100,
            center: Text(
              '${percentage.toInt()}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            progressColor: Colors.grey[400],
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$subscribers',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$title subscribers',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
class promographWidget extends StatefulWidget {
  @override
  _promographWidget createState() => _promographWidget();
}

class _promographWidget extends State<promographWidget> {
  int _selectedTab = 0;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: _selectedTab == 0 ? Colors.blue[900] : Colors.orange,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10)
                      ),
                    ),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'daily',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: _selectedTab == 1 ? Colors.blue[900] : Colors.orange,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10)
                      ),
                    ),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Weekly',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              child: Container(
                height: 400,
                width: 675,
                color: Color(0xFF001240),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 30,
                      child: Container(
                        height: 350,
                        width: 550,
                        child: _selectedTab == 0 ? LineChartWidget() : weeklyChartWidget(),
                      ),
                    ),

                    Positioned(
                      top: 16,
                      right: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 2,
                                width: 60,
                                color: Colors.blue,
                              ),
                              Text(
                                'Women',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Container(
                                height: 2,
                                width: 60,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Men',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 280,
      decoration: BoxDecoration(
        color: Color(0xFF001240),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Mon', style: TextStyle(color: Colors.white));
                    case 1:
                      return Text('Tue', style: TextStyle(color: Colors.white));
                    case 2:
                      return Text('Wed', style: TextStyle(color: Colors.white));
                    case 3:
                      return Text('Thu', style: TextStyle(color: Colors.white));
                    case 4:
                      return Text('Fri', style: TextStyle(color: Colors.white));
                    case 5:
                      return Text('Sat', style: TextStyle(color: Colors.white));
                    case 6:
                      return Text('Sun', style: TextStyle(color: Colors.white));
                    default:
                      return Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 80,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 20),
                FlSpot(1, 60),
                FlSpot(2, 40),
                FlSpot(3, 40),
                FlSpot(4, 20),
                FlSpot(5, 60),
                FlSpot(6, 40),
              ],
              isCurved: false,
              color: Colors.blue,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 40),
                FlSpot(1, 20),
                FlSpot(2, 60),
                FlSpot(3, 40),
                FlSpot(4, 60),
                FlSpot(5, 20),
                FlSpot(6, 20),
              ],
              isCurved: false,
              color: Colors.red,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class weeklyChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        color: Color(0xFF001240),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'weekly Graph Placeholder',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String label;

  const Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}