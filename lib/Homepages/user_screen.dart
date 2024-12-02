import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';

class userscreen extends StatefulWidget {
  @override
  _userscreenstate createState() => _userscreenstate();
}

class _userscreenstate extends State<userscreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
   bool isEditMode = false; // Flag to toggle edit mode
  bool isManageButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar
            Expanded(
              flex: 2, // Sidebar takes 2/10 of the width
              child: SidebarLayout(),
            ),
            // Main Content Area
            Expanded(
              flex: 8, // Main content takes 8/10 of the width
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        SizedBox(height: 3),
                        Divider(color: Colors.grey,),
                        SizedBox(height: 7),
                        _buildBoostedStrandedTagsRow(),
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
                  _buildActionButtons(),
                  _buildEditButton(),
                  _buildRankTypeButton(),
                  _buildRankNoButton(),
                  _buildSendMessageButton(),
                  _buildSearchBar(),
                ],
              ),
            ),
          ],
        ),
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
            SizedBox(width: 10),
            _buildUserInfo(),
          ],
        ),
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
        radius: 32,
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
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1C1C),
          ),
        ),
        Text(
          "User ID",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.2,
            color: Color(0xFF6F6F6F),
          ),
        ),
      ],
   );
  }

  // Action Buttons with Positioning
 Widget _buildActionButtons() {
  return Stack(
    children: [
      // Top Action Buttons
      Positioned(
        top: 25, // Adjust the distance from the top as needed
        right: 20, // You can adjust the horizontal alignment as well
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the left or center as needed
          children: [
            _buildOutlinedButton("Suspend", 75),
            SizedBox(width: 10),
            _buildOutlinedButton("Delete", 47),
            SizedBox(width: 10),
            _buildOutlinedButton("Ban", 50),
            SizedBox(width: 20),
          ],
        ),
      ),
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
    final tabWidths = [145.0, 155.0, 168.0, 85.0, 88.0];

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
                  fontSize: 14,
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

  Widget _buildBoostedStrandedTagsRow() {
  return Wrap(
    alignment: WrapAlignment.center, // Aligns content horizontally
    spacing: 8, // Space between tags
    children: [
      _buildTag("Boosted", Color(0xFF0703F1), Color(0xFFEFF1FA)),
      _buildTag("Stranded", Color(0xFF34C759), Color(0xFFEFFAF2)),
    ],
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
            isEnabled: isManageButtonEnabled, // Pass the enabled state
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
          fontSize: 14,
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
      height: 20,
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

 Widget _buildEditButton() {
    return Positioned(
      top: 142,
      right: 20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEditMode = !isEditMode; // Toggle edit mode
            isManageButtonEnabled = !isManageButtonEnabled; // Enable or disable manage buttons
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(isEditMode ? "Edit Mode Activated" : "View Mode")),
          );
        },
        child: _buildColoredButton(isEditMode ? "Save" : "Edit", Color(0xFF6F6F6F)),
      ),
    );
  }



  Widget _buildRankTypeButton() {
    return Positioned(
      top: 145,
      right: 110,
      child: _buildRankButton("Rank Type (ABC)"),
    );
  }

  Widget _buildRankNoButton() {
    return Positioned(
      top: 145,
      right: 245,
      child: _buildRankButton("Rank No (123)"),
    );
  }

  Widget _buildSendMessageButton() {
  return Positioned(
    top: 90,
    right: 200,
    child: GestureDetector(
      onTap: () {
        // Show a SnackBar as a placeholder action for sending a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Message Sent")),
        );
      },
      child: Container(
        width: 120,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xFF0703F1), // Background color
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Center(
          child: Text(
            "Send Message", // Button text
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 22 / 18, // Line height
              color: Color(0xFFF3F2F2), // Text color
            ),
          ),
        ),
      ),
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
              controller: searchController, // The controller to manage the text input
              decoration: InputDecoration(
                hintText: 'Search', // Placeholder text
                border: InputBorder.none, // Removes the border around the text field
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD7D7D7),
                ),
              ),
              onSubmitted: (query) {
                setState(() {
                  searchQuery = query; // Store the search query
                });
                // You can perform the search or filtering here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Searching for: $searchQuery")),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
  }
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
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF3F2F2),
          ),
        ),
      ),
    );
  }

  Widget _buildRankButton(String label) {
    return Container(
      width: 120,
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
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6F6F6F),
          ),
        ),
      ),
    );
  }


// Custom Manage Button Widget
class ManageButton extends StatelessWidget {
  final String label;
  final double width;
  final bool isEnabled; // Add this parameter

  const ManageButton({
    required this.label,
    required this.width,
    required this.isEnabled, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 28, // Height is fixed as per the design
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), // border-radius
        border: Border.all(
          color: isEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0), // Lighter color when disabled
        ), // Border color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0), // Lighter text when disabled
              height: 19 / 16, // Line height ratio
            ),
          ),
          SizedBox(width: 5), // Space before the chevron
          Icon(
            Icons.expand_more, // Placeholder for chevron-down
            size: 12,
            color: isEnabled ? Color(0xFFD7D7D7) : Color(0xFFB0B0B0), // Lighter chevron when disabled
          ),
        ],
      ),
    );
  }
}
