import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PromosOffersPage extends StatefulWidget {
  @override
  _PromosOffersPageState createState() => _PromosOffersPageState();
}

class _PromosOffersPageState extends State<PromosOffersPage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Promo & Offers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  )),
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('create promo'),
                      ),
                      SizedBox(
                        width: 4,
                        height: 5,
                      ),
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
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      _buildTabButton('Active Promo', 0),
                      _buildTabButton('Package Promo', 1),
                      _buildTabButton('Upcoming Promo', 2),
                      _buildTabButton('Expired Promo', 3),
                    ],
                  ),
                ),
                Expanded(
                  child: _selectedTabIndex == 0
                      ? _buildactivepromoView()
                      : Text('Reconstruction'),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white70 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.white70,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.grey : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildactivepromoView() {
    return Center(
        child: Container(
            height: 950,
            width: 1250,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ]),
            child: Column(
                children: [
              Row(children: [
                _buildpromocard(
                  // context: context,
                  title: 'Promo 1',
                  datefrom: '12/02/2020',
                  dateto: '12/03/2020',
                  timefrom: '11:00 AM',
                  timeto: '2:00 PM',
                  remainingday: 0,
                  remaininghr: 0,
                  remainingmn: 0,
                ),
                SizedBox(
                  height: 16,
                  width: 15,
                ),
                _buildpromocard(
                  // context: context,
                  title: 'Promo 2',
                  datefrom: '15/02/2020',
                  dateto: '20/03/2020',
                  timefrom: '10:00 AM',
                  timeto: '4:00 PM',
                  remainingday: 5,
                  remaininghr: 12,
                  remainingmn: 30,
                ),
                SizedBox(width: 18),
                _buildsplpromocard(
                  // context: context,
                  title: 'Promo 3',
                  totalusers: 100,
                  remainingusers: 33,
                ),
              ]),
              Row(children: [
                _buildpromocard(
                  // context: context,
                  title: 'Promo 4',
                  datefrom: '12/02/2020',
                  dateto: '12/03/2020',
                  timefrom: '11:00 AM',
                  timeto: '2:00 PM',
                  remainingday: 0,
                  remaininghr: 0,
                  remainingmn: 0,
                ),
                SizedBox(
                  height: 16,
                  width: 15,
                ),
                _buildpromocard(
                  // context: context,
                  title: 'Promo 5',
                  datefrom: '15/02/2020',
                  dateto: '20/03/2020',
                  timefrom: '10:00 AM',
                  timeto: '4:00 PM',
                  remainingday: 5,
                  remaininghr: 12,
                  remainingmn: 30,
                ),
                SizedBox(width: 18),
                _buildpromocard(
                  // context: context,
                  title: 'Promo 6',
                  datefrom: '01/03/2020',
                  dateto: '10/03/2020',
                  timefrom: '9:00 AM',
                  timeto: '5:00 PM',
                  remainingday: 2,
                  remaininghr: 4,
                  remainingmn: 15,
                ),
              ]),
            ])));
  }
}

Widget _buildpromocard({
  // required BuildContext context,
  required String datefrom,
  required String dateto,
  required String timefrom,
  required String timeto,
  required int remainingday,
  required int remaininghr,
  required String title,
  required int remainingmn,
}) {
  // return GestureDetector(
  //     onTap: () {
  //   // Add navigation
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PromoDetailPage(title: title)),
  //   );
  // },
  // child:
  return Stack(children: [
    Container(
      width: 350,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
            width: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(datefrom.toString(), 'From'),
                  _buildPriceBox(dateto.toString(), 'To'),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(timefrom.toString(), 'From'),
                  _buildPriceBox(timeto.toString(), 'To'),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time Remaining',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(remainingday.toString(), 'Days'),
                  _buildPriceBox(remaininghr.toString(), 'hr'),
                  _buildPriceBox(remainingmn.toString(), 'mn'),
                ],
              )
            ],
          )
        ],
      ),
    ),
    Positioned(
      top: -3,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
    )
  ]);
}

Widget _buildsplpromocard({
  // required BuildContext context,

  required String title,
  required int totalusers,
  required int remainingusers,
}) {
  // return GestureDetector(
  //     onTap: () {
  //   // Add navigation
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PromoDetailPage(title: title)),
  //   );
  // },
  // child:
  return Stack(children: [
    Container(
      width: 350,
      height: 220,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
            width: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total users',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                'Remaining users',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBox(remainingusers.toString(), ''),
                ],
              )
            ],
          ),
        ],
      ),
    ),
    Positioned(
      top: -3,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
    )
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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
