import 'package:dashboard_my_mate/MymateThemes.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';

class Viewadminpage extends StatelessWidget {
  const Viewadminpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final sidebarWidth = screenWidth * 0.2 < 100 ? 100.0 : screenWidth * 0.2;

    final outerPadding = screenWidth * 0.005;

    final innerPadding = screenWidth * 0.02;

    final topSectionHeight = screenHeight * 0.01;

    final availableHeight = screenHeight - topSectionHeight - (outerPadding * 2);

    return Scaffold(
      backgroundColor: Mymatethemes.backgroundColor,
      body: Row(
        children: [
          Container(
            width: sidebarWidth,
            color: Colors.grey.shade200,
            child: SidebarLayout(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(outerPadding, outerPadding, outerPadding, 0),
                        child: Text(
                          "Operators",
                          style: TextStyle(
                            fontSize: screenWidth * 0.014,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: outerPadding / 2),
                        child: const Divider(thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: outerPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Mymatethemes.backgroundColor,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01,
                                  horizontal: screenWidth * 0.01,
                                ),
                                side: const BorderSide(color: Mymatethemes.premium),
                              ),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.01,
                                  color: Mymatethemes.premium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                              child: Container(
                                width: 1,
                                height: screenHeight * 0.04,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                              width: screenWidth * 0.07,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.00),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: outerPadding / 2),
                        child: const Divider(thickness: 1),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(outerPadding),
                          child: SizedBox(
                            height: availableHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.all(innerPadding),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: screenHeight * 0.01),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'User',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenWidth * 0.012),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Action',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenWidth * 0.012),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenWidth * 0.012),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Time',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenWidth * 0.012),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(height: screenHeight * 0.02, color: Colors.grey),
                                          Expanded(
                                            child: ListView(
                                              children: [
                                                _buildRecordRow(
                                                  context: context,
                                                  user: 'Username',
                                                  action: 'Delete',
                                                  actionColor: Colors.red,
                                                  date: '10/03/2025',
                                                  time: '11:35 AM',
                                                ),
                                                _buildRecordRow(
                                                  context: context,
                                                  user: 'Username',
                                                  action: 'Create',
                                                  actionColor: Colors.green,
                                                  date: '10/03/2025',
                                                  time: '11:35 AM',
                                                ),
                                                _buildRecordRow(
                                                  context: context,
                                                  user: 'Username',
                                                  action: 'Suspend',
                                                  actionColor: Colors.orange,
                                                  date: '10/03/2025',
                                                  time: '11:35 AM',
                                                ),
                                                _buildRecordRow(
                                                  context: context,
                                                  user: 'Username',
                                                  action: 'Ban',
                                                  actionColor: Colors.red,
                                                  date: '10/03/2025',
                                                  time: '11:35 AM',
                                                ),
                                                _buildRecordRow(
                                                  context: context,
                                                  user: 'Username',
                                                  action: 'Delete',
                                                  actionColor: Colors.red,
                                                  date: '10/03/2025',
                                                  time: '11:35 AM',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                    margin: EdgeInsets.symmetric(vertical: innerPadding),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.all(innerPadding),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: screenWidth * 0.1,
                                              height: screenWidth * 0.1,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue.shade100,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.person,
                                                  size: screenWidth * 0.08,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.03),
                                          _buildLabelField(
                                            label: 'Name',
                                            value: '26 years',
                                            context: context,
                                          ),
                                          SizedBox(height: screenHeight * 0.015),
                                          _buildLabelField(
                                            label: 'Admin ID',
                                            value: '@1234JK',
                                            context: context,
                                          ),
                                          SizedBox(height: screenHeight * 0.015),
                                          _buildLabelField(
                                            label: 'Password',
                                            value: '*KodikLx',
                                            context: context,
                                          ),
                                          SizedBox(height: screenHeight * 0.015),
                                          _buildLabelField(
                                            label: 'Admin Type',
                                            value: 'Manager',
                                            context: context,
                                          ),
                                          SizedBox(height: screenHeight * 0.015),
                                          _buildLabelField(
                                            label: 'Address',
                                            value: 'Jaffna',
                                            context: context,
                                          ),
                                          SizedBox(height: screenHeight * 0.015),
                                          _buildLabelField(
                                            label: 'Contact Number',
                                            value: '0781920028',
                                            context: context,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordRow({
    required BuildContext context,
    required String user,
    required String action,
    required Color actionColor,
    required String date,
    required String time,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005 + 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(user, style: TextStyle(fontSize: screenWidth * 0.011)),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  action,
                  style: TextStyle(
                    fontSize: screenWidth * 0.011,
                    color: actionColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(date, style: TextStyle(fontSize: screenWidth * 0.011)),
              ),
              Expanded(
                flex: 2,
                child: Text(time, style: TextStyle(fontSize: screenWidth * 0.011)),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade300),
      ],
    );
  }

  Widget _buildLabelField({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: screenWidth * 0.15,
          child: Text(
            label,
            style: TextStyle(fontSize: screenWidth * 0.011),
          ),
        ),
        Expanded(
          child: TextFormField(
            style: TextStyle(fontSize: screenWidth * 0.011),
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.005,
                horizontal: screenWidth * 0.005,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
