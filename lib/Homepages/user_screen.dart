import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';

class userscreen extends StatefulWidget {
  @override
  _userscreenstate createState() => _userscreenstate();
}

class _userscreenstate extends State<userscreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: [
          // Main Content Area
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSection(),
                      SizedBox(height: 10),
                      Divider(color: Colors.grey),
                      SizedBox(height: 15),
                      _buildTabsSection(),
                      SizedBox(height: 15),
                      Divider(color: Colors.grey),
                      SizedBox(height: 15),
                      _buildManageButtonsRow(),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildExitButton(),
          _buildRankTypeButton(),
          _buildRankNoButton(),
          _buildSendMessageButton(),
          _buildSearchBar(),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfilePicture(),
            SizedBox(width: 20),
            _buildUserInfo(),
          ],
        ),
        _buildActionButtons(),
      ],
    );
  }

  // Profile Picture
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
        radius: 35,
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 35, color: Colors.grey),
      ),
    );
  }

  // User Info
  Widget _buildUserInfo() {
    return Column(
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
            height: 1.2,
            color: Color(0xFF6F6F6F),
          ),
        ),
        SizedBox(height: 20),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTag("Boosted", Color(0xFF0703F1), Color(0xFFEFF1FA)),
            SizedBox(width: 8),
            _buildTag("Stranded", Color(0xFF34C759), Color(0xFFEFFAF2)),
          ],
        ),
      ],
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildOutlinedButton("Suspend", 75),
        SizedBox(width: 10),
        _buildOutlinedButton("Delete", 47),
        SizedBox(width: 10),
        _buildOutlinedButton("Ban", 50),
        SizedBox(width: 20),
      ],
    );
  }

  // Tabs Section
  Widget _buildTabsSection() {
    final tabs = [
      "Connection (1234)",
      "Send interest (123)",
      "Receive interest (345)",
      "Block (12)",
      "Report (3)",
    ];

    // Widths for each tab to match the specified layout.
    final tabWidths = [161.0, 165.0, 188.0, 95.0, 98.0];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(tabs.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            width: tabWidths[index],
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6F6F6F),
                  height: 19 / 16, // Line height
                ),
              ),
            ),
          ),
        );
      }),
    );
  }


  Widget _buildManageButtonsRow() {
    final labels = ["Add to Category", "Offer Coupon", "Add Status", "Add Boosts"];
    final buttonWidths = [166.0, 136.0, 121.0, 121.0]; // Corresponds to the specified widths

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(labels.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10), // Gap between buttons
          child: ManageButton(
            label: labels[index],
            width: buttonWidths[index],
          ),
        );
      }),
    );
  }


  // Tags
  Widget _buildTag(String label, Color textColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 22 / 18,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Buttons
  Widget _buildOutlinedButton(String title, double width) {
    return Container(
      width: width,
      height: 25,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(color: Color(0xFFFF2626)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(color: Color(0xFFFF2626), fontSize: 12),
        ),
      ),
    );
  }

  // Positioned Buttons/Elements
  Widget _buildExitButton() {
    return Positioned(
      top: 190,
      left: 1442,
      child: _buildColoredButton("Exit", Color(0xFF6F6F6F)),
    );
  }

  Widget _buildRankTypeButton() {
    return Positioned(
      top: 195,
      left: 1143,
      child: _buildRankButton("Rank Type (ABC)"),
    );
  }

  Widget _buildRankNoButton() {
    return Positioned(
      top: 195,
      left: 1290,
      child: _buildRankButton("Rank No (123)"),
    );
  }

  Widget _buildSendMessageButton() {
    return Positioned(
      top: 117,
      left: 1150,
      child: Container(
        width: 157,
        height: 35,
        decoration: BoxDecoration(
          color: Color(0xFF0703F1), // Background color
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        child: Center(
          child: Text(
            "Send Message", // Button text
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 22 / 18, // Line height
              color: Color(0xFFF3F2F2), // Text color
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSearchBar() {
    return Positioned(
      top: 120,
      right: 20,
      child: Container(
        width: 165,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFFD7D7D7), size: 20),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD7D7D7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Buttons
  Widget _buildColoredButton(String label, Color color) {
    return Container(
      width: 75,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF3F2F2),
          ),
        ),
      ),
    );
  }

  Widget _buildRankButton(String label) {
    return Container(
      width: 141,
      height: 28,
      padding: EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          label,
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

// Custom Manage Button Widget
class ManageButton extends StatelessWidget {
  final String label;
  final double width;

  const ManageButton({
    required this.label,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 28, // Height is fixed as per the design
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), // border-radius
        border: Border.all(color: Color(0xFFD7D7D7)), // Border color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFD7D7D7), // text color
              height: 19 / 16, // Line height ratio
            ),
          ),
          SizedBox(width: 5), // Space before the chevron
          Icon(
            Icons.expand_more, // Placeholder for chevron-down
            size: 12,
            color: Color(0xFFD7D7D7), // Chevron color matches border
          ),
        ],
      ),
    );
  }
}
