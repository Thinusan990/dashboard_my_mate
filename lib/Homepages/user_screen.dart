import 'package:flutter/material.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isEditMode = false;
  bool isManageButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: SidebarLayout()),
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        SizedBox(height: 3),
                        Divider(color: Colors.grey),
                        SizedBox(height: 7),
                        _buildTagsRow(),
                        SizedBox(height: 7),
                        Divider(color: Colors.grey),
                        SizedBox(height: 5),
                        _buildTabsSection(),
                        SizedBox(height: 5),
                        Divider(color: Colors.grey),
                        SizedBox(height: 5),
                        _buildManageButtonsRow(),
                      ],
                    ),
                  ),
                  _buildSearchBar(),
                  _buildEditButton(),
                  _buildRankButtons(),
                  _buildSendMessageButton(),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildProfilePicture(),
            SizedBox(width: 10),
            _buildUserInfo(),
          ],
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFFE6E6E6),
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF6F6F6F), width: 5),
      ),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 35, color: Colors.grey),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("User’s full Name", style: _textStyle(20, FontWeight.w500)),
        Text("User ID", style: _textStyle(14, FontWeight.w400, Color(0xFF6F6F6F))),
      ],
    );
  }

  Widget _buildTagsRow() {
    return Wrap(
      spacing: 8,
      children: [
        _buildTag("Boosted", Color(0xFF0703F1), Color(0xFFEFF1FA)),
        _buildTag("Stranded", Color(0xFF34C759), Color(0xFFEFFAF2)),
      ],
    );
  }

  Widget _buildTag(String label, Color textColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(26)),
      child: Text(label, style: _textStyle(14, FontWeight.w400, textColor)),
    );
  }

  Widget _buildTabsSection() {
    final tabs = [
      "Connection (1234)",
      "Send interest (123)",
      "Receive interest (345)",
      "Block (12)",
      "Report (3)"
    ];
    final tabWidths = [145.0, 155.0, 168.0, 85.0, 88.0];

    return Row(
      children: List.generate(tabs.length, (index) {
        return Container(
          width: tabWidths[index],
          height: 28,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(tabs[index], style: _textStyle(14, FontWeight.w400))),
        );
      }),
    );
  }

  Widget _buildManageButtonsRow() {
    final labels = ["Add to Category", "Offer Coupon", "Add Status", "Add Boosts"];
    final buttonWidths = [166.0, 136.0, 121.0, 121.0];

    return Row(
      children: List.generate(labels.length, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 10),
          child: _buildManageButton(labels[index], buttonWidths[index]),
        );
      }),
    );
  }

  Widget _buildManageButton(String label, double width) {
    return Container(
      width: width,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: isManageButtonEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: _textStyle(14, FontWeight.w400, isManageButtonEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0))),
          SizedBox(width: 5),
          Icon(Icons.expand_more, size: 12, color: isManageButtonEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 84,
      right: 20,
      child: Container(
        width: 160,
        height: 42.5,
        padding: EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFFD7D7D7), size: 20),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  hintStyle: _textStyle(12, FontWeight.w400, Color(0xFFD7D7D7)),
                ),
                onSubmitted: (query) {
                  setState(() => searchQuery = query);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Searching for: $query")));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      top: 142,
      right: 20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEditMode = !isEditMode;
            isManageButtonEnabled = !isManageButtonEnabled;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEditMode ? "Edit Mode Activated" : "View Mode")));
        },
        child: _buildColoredButton(isEditMode ? "Save" : "Edit", Color(0xFF6F6F6F)),
      ),
    );
  }

  Widget _buildRankButtons() {
    return Positioned(
      top: 145,
      right: 150,
      child: Row(
        children: [
          _buildRankButton("Rank No (123)"),
          SizedBox(width: 5),
          _buildRankButton("Rank Type (ABC)"),
        ],
      ),
    );
  }

  Widget _buildRankButton(String label) {
    return Container(
      width: 120,
      height: 28,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: Text(label, style: _textStyle(12, FontWeight.w400))),
    );
  }

  Widget _buildSendMessageButton() {
    return Positioned(
      top: 90,
      right: 190,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending message...")));
        },
        child: _buildColoredButton("Send Message", Color(0xFF0703F1)),
      ),
    );
  }

  Widget _buildActionButtons() {
    final buttonLabels = ["Suspend", "Delete", "Ban"];
    final buttonPositions = [20, 100, 180];

    return Positioned(
      top: 40,
      right:20,
      child: Row(
        children: List.generate(buttonLabels.length, (index) {
          return Padding(
           child: OutlinedButton(
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Performing ${buttonLabels[index]}")));
  },
  style: OutlinedButton.styleFrom(
    padding: EdgeInsets.zero,
    side: BorderSide(color: Color(0xFFFF2626)), // Border color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), // Rounded corners
    ),
  ),
  child: Text(
    buttonLabels[index], // Using the label from the original button
    style: TextStyle(
      color: Color(0xFFFF2626), // Text color matching border
      fontSize: 12, // Font size
    ),
  ),
),
 padding: EdgeInsets.only(right: 10),
            
          );
        }),
      ),
    );
  }

  Widget _buildColoredButton(String label, Color color) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text(label, style: _textStyle(14, FontWeight.w600, Color(0xFFF3F2F2)))),
    );
  }

  TextStyle _textStyle(double size, FontWeight weight, [Color? color]) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color ?? Colors.black);
  }
}
