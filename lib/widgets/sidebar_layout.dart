import 'package:flutter/material.dart';

class SidebarLayout extends StatefulWidget {
  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  bool isManageUserExpanded = false;
  String selectedCategory = "Select Category";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Color(0xFF444444),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // Perform search logic
                print("Searching for: $value");
              },
            ),
          ),

          _buildSidebarItem(Icons.home, "Home", 16, () {}),
          _buildManageUserTile(),
          _buildSidebarItem(
              Icons.local_fire_department_outlined, "Tokens", 16, () {}),
          _buildSidebarItem(Icons.trending_up_sharp, "Statistics", 16, () {}),
          _buildSidebarItem(Icons.headset_mic, "Support & Report", 16, () {}),
          _buildSidebarItem(Icons.ad_units, "Third Party Adds", 16, () {}),
          _buildSidebarItem(
              Icons.local_offer_outlined, "Promo & Offers", 16, () {}),
          _buildSidebarItem(Icons.bolt, "Boosts", 16, () {}),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, double fontSize,
      VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
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
          Icon(Icons.person, color: Colors.white),
          SizedBox(width: 8),
          Text('Users', style: TextStyle(color: Colors.white)),
        ],
      ),
      trailing: Icon(
        isManageUserExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        color: Colors.white,
      ),
      backgroundColor: Color(0xFF444444),
      children: [
        _buildSubSidebarItem("New User", () {}),
        _buildSubSidebarItem("Active User", () {}),
        _buildSubSidebarItem("Inactive User", () {}),
        _buildCategoryDropdown(),

      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          isManageUserExpanded = expanded;
        });
      },
    );
  }

  Widget _buildSubSidebarItem(String title, Function onPressed) {
    return ListTile(
      leading: SizedBox(width: 32), // Align with sidebar items
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => onPressed(),
    );
  }

  Widget _buildCategoryDropdown() {
    return ListTile(
      leading: SizedBox(width: 30),
        title: DropdownButton<String>(
        value: selectedCategory,
        dropdownColor: Color(0xFF444444),
        style: TextStyle(color: Colors.white),
        underline: Container(),
        // Remove underline
        items: [
          DropdownMenuItem<String>(
            value: "Select Category",
            child: Text(
                " Category", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: "Category 1",
            child: Text("Category 1", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: "Category 2",
            child: Text("Category 2", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: "Category 3",
            child: Text("Category 3", style: TextStyle(color: Colors.white)),
          ),
          // Add Category option
          DropdownMenuItem<String>(
            value: "Add Category",
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 8),
                Text("Add Category", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          if (value == "Add Category") {
            _handleAddCategory(); // Call the add category handler
          } else {
            setState(() {
              selectedCategory = value!;
            });
          }
          print("Selected Category: $value");
        },
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      ),
    );
  }

  void _handleAddCategory() {
    print("Add Category Selected");
    // Implement logic to add a category, e.g., open a dialog or perform an action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Category"),
          content: TextField(
            decoration: InputDecoration(
              labelText: "Enter Category Name",
            ),
            onSubmitted: (value) {
              // Handle category addition logic here
              Navigator.of(context).pop();
              print("New Category: $value");
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
