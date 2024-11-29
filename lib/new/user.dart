import 'package:flutter/material.dart';

void main() {
  runApp(MyMateApp());
}

class MyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyMatePage(),
    );
  }
}

class MyMatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Row(
        children: [
          // Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture and User Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(0xFFE6E6E6),
                            child: Icon(Icons.person, size: 40, color: Colors.white),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User’s full Name",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1C1C1C),
                                ),
                              ),
                              Text(
                                "User ID",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF6F6F6F),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildTag("Boosted", Color(0xFF0703F1)),
                                  SizedBox(width: 8),
                                  _buildTag("Stranded", Color(0xFF2DBF57)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                  // Divider
                  Divider(color: Colors.grey),
                  SizedBox(height: 20),
                      // Action Buttons
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text('Send Message'),
                          ),
                          SizedBox(width: 10),
                          _buildOutlinedButton("Suspend", 75),
                          SizedBox(width: 10),
                          _buildOutlinedButton("Delete", 47),
                          SizedBox(width: 10),
                          _buildOutlinedButton("Ban", 50),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Horizontal Wrap (Tabs)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTab("Connection (1234)")),
                      SizedBox(width: 8),
                      Expanded(child: _buildTab("Send interest (123)")),
                      SizedBox(width: 8),
                      Expanded(child: _buildTab("Receive interest (345)")),
                      SizedBox(width: 8),
                      Expanded(child: _buildTab("Block (12)")),
                      SizedBox(width: 8),
                      Expanded(child: _buildTab("Report (3)")),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Divider
                  Divider(color: Colors.grey),
                  SizedBox(height: 20),

                  // Add and Manage buttons (Row horizontally)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ManageButton(label: 'Add to Category'),
                      ManageButton(label: 'Offer Coupon'),
                      ManageButton(label: 'Add Status'),
                      ManageButton(label: 'Add Boosts'),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, {IconData? icon}) {
    return ListTile(
      leading: icon != null ? Icon(icon, size: 20, color: Color(0xFFABABAB)) : null,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xFFABABAB),
        ),
      ),
    );
  }

  Widget _buildSubSidebarItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color(0xFFABABAB),
        ),
      ),
    );
  }

  Widget _buildTag(String title, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

 Widget _buildOutlinedButton(String title, double width) {
  return Container(
    width: width, // Set the width dynamically
    height: 25,   // Set the fixed height
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero, 
        side: BorderSide(color: Color(0xFFFF2626)), // Red border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Border radius of 5px
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: Color(0xFFFF2626), fontSize: 12), // Red text
      ),
    ),
  );
}

  Widget _buildTab(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6F6F6F),
          ),
        ),
      ),
    );
  }
}

class ManageButton extends StatelessWidget {
  final String label;

  const ManageButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFFD7D7D7),
          fontSize: 16,
        ),
      ),
    );
  }
}