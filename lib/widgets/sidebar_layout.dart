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

          _buildSidebarItem("Home", 16, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );

          }),
          _buildManageUserTile(),
          _buildSidebarItem("Tokens", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );

            }
          }),
          _buildSidebarItem("Statistics", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem("Support & Report", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem("Third Party Adds", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem("Promo & Offers", 16, () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          }),
          _buildSidebarItem("Boosts", 16, () {
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

  Widget _buildSidebarItem(String title, double fontSize, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
      onTap: onTap,
    );
  }

  Widget _buildManageUserTile() {
    return ExpansionTile(
      title: Text(
        'Manage User',
        style: TextStyle(color: Colors.white),
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
