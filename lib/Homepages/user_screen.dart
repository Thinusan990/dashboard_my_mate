import 'package:dashboard_my_mate/users_details/expectations.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:dashboard_my_mate/Homepages/tokens_screen.dart';

import '../dbconnection/firebase.dart';
import '../user_chart/User_chart.dart';
import '../users_details/user_package.dart';

class UserScreen extends StatefulWidget {
  final String userId;

    const UserScreen({Key? key, required this.userId}) : super(key: key);


  @override
  _UserScreenState createState() => _UserScreenState();
}



class _UserScreenState extends State<UserScreen> {
  late Future<Map<String, dynamic>> _userDetails;

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isEditMode = false;
  bool isManageButtonEnabled = false;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _userDetails = FirebaseService().fetchUserById(widget.userId);
  }

  Widget aboutmeWidget(Map<String, dynamic> userData) {
    return Container(
      width: 650,
      height: 750,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE6E6E6),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: ListView(
          children: [
            _buildRow('Age', userData['age'] != null ? '${userData['age']}' : 'N/A'),
            _buildRow('Date of Birth', userData['date_of_birth'] ?? 'N/A'),
            _buildRow('Occupation', userData['occupation'] ?? 'N/A'),
            _buildRow('Address', userData['address'] ?? 'N/A'),
            _buildRow('Education', userData['education'] ?? 'N/A'),
            _buildRow('Height', userData['height'] ?? 'N/A'),
            _buildRow('Religion', userData['religion'] ?? 'N/A'),
            _buildRow('Caste', userData['caste'] ?? 'N/A'),
            _buildRow('Contact No', userData['contact'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget moreaboutmeWidget(Map<String, dynamic> userData) {
    return Container(
      width: 650,
      height: 750,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE6E6E6),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: ListView(
          children: [
            _buildRow('Hobby', userData['hobbies'] != null
                ? '${userData['hobbies']}'
                : 'N/A'),
            _buildRow('Favorites',
                userData['Favorites'] ?? 'N/A'),
            _buildRow('Alcohol',
                userData['alcohol'] ?? 'N/A'),
            _buildRow('sports', userData['sports'] ?? 'N/A'),
            _buildRow('cooking', userData['cooking'] ?? 'N/A'),
            _buildRow('Bio', userData['Bio'], isBio: true),
            _buildPhotoSection('photo', userData['images'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, dynamic value, {bool isBio = false}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 50,
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Title Text
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                fontSize: 14,
                height: 1.19,
                color: Color(0xFF6F6F6F),
              ),
            ),


            Container(
                width: 250,
                height: isBio ? 100 : 50,
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE6E6E6)), // Border color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    value != null ? value.toString() : 'N/A',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF6F6F6F),
                    ),
                  ),
                )),
          ]),
        ));
  }

  Widget _buildPhotoSection(String title, dynamic photoData) {
    List<dynamic> photos = (photoData is List) ? photoData : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w200,
            fontSize: 16,
            height: 1.19,
            color: Color(0xFF6F6F6F),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            3,
                (index) {
              if (index < photos.length) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFFE6E6E6)),
                    ),
                    child: Image.network(
                      photos[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image, color: Colors.grey[600]),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xFFE6E6E6)),
                  ),
                  child: Icon(Icons.image, color: Colors.grey[600]),
                );
              }
            },
          ),
        ),
      ],
    );
  }


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
                        SizedBox(height: 1),
                        Divider(color: Colors.grey),
                        SizedBox(height: 1),
                        _buildTagsRow(),
                        SizedBox(height: 2),
                        Divider(color: Colors.grey),
                        SizedBox(height: 2),
                        _buildTabsSection(),
                        SizedBox(height: 1),
                        Divider(color: Colors.grey),
                        SizedBox(height: 2),
                        _buildManageButtonsRow(),
                        SizedBox(height: 10), // Add some space
                        _buildThreeContainers(), // New containers added here
                      ],
                    ),
                  ),
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
        _buildActionButtons(),
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
        Text("User’s full Name", style: _textStyle(18, FontWeight.w500)),
        Text("User ID",
            style: _textStyle(14, FontWeight.w400, Color(0xFF6F6F6F))),
      ],
    );
  }

  Widget _buildTagsRow() {
    return Row(
      children: [
        _buildTag("Boosted", Color(0xFF0703F1), Color(0xFFEFF1FA)),
        SizedBox(width: 8),
        _buildTag("Stranded", Color(0xFF34C759), Color(0xFFEFFAF2)),
        Spacer(),
        _buildSendMessageButton(),
        SizedBox(width: 8),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildTag(String label, Color textColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(26)),
      child: Text(label, style: _textStyle(14, FontWeight.w400, textColor)),
    );
  }

  Widget _buildTabsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabButtons(),
        Spacer(), // Push the rank buttons to the right
        _buildRankButtons(),
        SizedBox(width: 8),
        _buildEditButton(), // Rank buttons // Call to build the individual tab buttons
      ],
    );
  }

  Widget _buildTabButtons() {
    final tabs = [
      "Connection (1234)",
      "Send interest (123)",
      "Receive interest (345)",
      "Block (12)",
      "Report (3)"
    ];

    final tabWidths = [145.0, 155.0, 168.0, 85.0, 88.0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(tabs.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Container(
            width: tabWidths[index],
            height: 28,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                tabs[index],
                style: _textStyle(
                  14,
                  FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 160,
      height: 35,
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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Searching for: $query")));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendMessageButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sending message...")));
      },
      child: _buildColoredButton("Send Message", Color(0xFF0703F1)),
    );
  }

  Widget _buildActionButtons() {
    final buttonLabels = ["Suspend", "Delete", "Ban"];
    return Positioned(
      top: 40,
      right: 20,
      child: Row(
        children: List.generate(buttonLabels.length, (index) {
          return Padding(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Performing ${buttonLabels[index]}")));
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(color: Color(0xFFFF2626)), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: Text(
                buttonLabels[index],
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
      child: Center(
          child: Text(label,
              style: _textStyle(14, FontWeight.w600, Color(0xFFF3F2F2)))),
    );
  }

  TextStyle _textStyle(double size, FontWeight weight, [Color? color]) {
    return TextStyle(
        fontSize: size, fontWeight: weight, color: color ?? Colors.black);
  }

  Widget _buildRankButtons() {
    return Positioned(
      top: 130,
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
      width: 125,
      height: 28,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: Text(label, style: _textStyle(14, FontWeight.w400))),
    );
  }

  Widget _buildEditButton() {
    return SizedBox(
      width: 75,
      height: 30,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEditMode = !isEditMode;
            isManageButtonEnabled = !isManageButtonEnabled;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isEditMode ? "Edit Mode Activated" : "View Mode")));
        },
        child: _buildColoredButton(
            isEditMode ? "Save" : "Edit", Color(0xFF6F6F6F)),
      ),
    );
  }

  Widget _buildThreeContainers() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 750,
            margin: EdgeInsets.all(5),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [

                _buildTabButton('About me',0),
                _buildTabButton('More about me ', 1),
                _buildTabButton('Expectation', 2),

      ],
            ),
                Expanded(
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _userDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final userData = snapshot.data!;
                        return _selectedTabIndex == 0
                            ? aboutmeWidget(userData)
                            : _selectedTabIndex == 1
                            ? moreaboutmeWidget(userData)
                            : Center(child: Expectationchart());

                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 750,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: User_chart()
          ),
        ),
        Expanded(
          child: Container(
            height: 750,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: UserpackageWidget(),

          ),
        ),
      ],
    );
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
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

  Widget _buildManageButtonsRow() {
    final labels = [
      "Add to Category",
      "Offer Coupon",
      "Add Status",
      "Add Boosts"
    ];
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
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(
            color:
                isManageButtonEnabled ? Color(0xFF6F6F6F) : Color(0xFFB0B0B0)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: _textStyle(
              14,
              FontWeight.w400,
              isManageButtonEnabled ? Color(0xFF6F6F6F) : Color(0xFFB0B0B0),
            ),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.expand_more,
            size: 12,
            color:
                isManageButtonEnabled ? Color(0xFF6F6F6F) : Color(0xFFB0B0B0),
          ),
        ],
      ),
    );
  }
}

