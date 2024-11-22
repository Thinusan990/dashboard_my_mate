import 'package:dashboard_my_mate/Homepages/home_screen.dart';
import 'package:flutter/material.dart';

class SidebarLayout extends StatefulWidget {
  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  bool isManageUserExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      color: Color(0xFF424040),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'My Mate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          _buildSidebarItem(Icons.home,"Home", 16, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );

          }),
          _buildManageUserTile(),
          _buildSidebarItem(Icons.local_fire_department_outlined,"Tokens", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );

            }
          }),
          _buildSidebarItem(Icons.trending_up_sharp,"Statistics", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem(Icons.headset_mic,"Support & Report", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem(Icons.ad_units,"Third Party Adds", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem(Icons.local_offer_outlined,"Promo & Offers", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem(Icons.bolt,"Boosts",  16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon,String title, double fontSize, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
      onTap: onTap,
    );
  }

  Widget _buildManageUserTile() {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Icons.person, // User icon
            color: Colors.white,
          ),
          SizedBox(width: 8), // Space between the icon and text
          Text(
            'Users',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      trailing: Icon(
        isManageUserExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        color: Colors.white,
      ),
      backgroundColor: Color(0xFF444444),
      children: [
        _buildSubSidebarItem("New User", () {
          // Handle New User navigation
        }),
        _buildSubSidebarItem("Active User", () {
          // Handle Active User navigation
        }),
        _buildSubSidebarItem("Inactive User", () {
          // Handle Inactive User navigation
        }),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          isManageUserExpanded = expanded;
        });
      },
    );
  }

  Widget _buildSubSidebarItem(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 40.0),
      title: Text(
        title,
        style: TextStyle(color: Colors.white70),
      ),
      onTap: onTap,
    );
  }
}
