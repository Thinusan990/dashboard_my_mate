import 'package:dashboard_my_mate/Homepages/home_screen.dart';
import 'package:dashboard_my_mate/MymateThemes.dart';
import 'package:flutter/material.dart';

import '../Homepages/manage_user.dart';

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
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
        return
          Expanded(
            child: Container(
              width: width * 0.1,
              height: height*1,
              color: Mymatethemes.sidemenuColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: Text(
                      'My Mate',
                      style: TextStyle(
                        color: Mymatethemes.editabletextclr,
                        fontSize: width * 0.015,
                        fontWeight: FontWeight.w600,
                          letterSpacing: 0.8
                      ),
                    ),
                  ),

                  // SEARCH BAR
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:width*0.01,vertical: height*0.001),
                    child:
                        Container(
                          height:height*0.045 ,
                          width: width*0.17,
                         decoration: BoxDecoration(
                          border: Border.all(color: Mymatethemes.sidemenutextcolor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(width*0.003),
                  ),
                          child: TextField(
                            controller: searchController,
                            cursorColor: Mymatethemes.textcolor,
                            style: TextStyle(
                              fontSize: width*0.011,
                              color: Mymatethemes.textcolor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color:Mymatethemes.sidemenutextcolor.withOpacity(0.3),fontSize: width*0.011),
                              prefixIcon: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:width*0.01,vertical: height*0.005),
                                child:Icon(Icons.search,size: height*0.03, color: Mymatethemes.sidemenutextcolor.withOpacity(0.4)) ,
                                //       prefixIcon: Icon(Icons.search, color: Mymatethemes.sidemenutextcolor),

                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:  EdgeInsets.symmetric(vertical:height*0.017),
                              border: InputBorder.none
                              // border:OutlineInputBorder(
                              //   borderSide: BorderSide(color:Colors.red),
                              //
                              //   borderRadius: BorderRadius.circular(width*0.005),
                              //
                              // ),

                            ),
                            onChanged: (value) {
                              // Perform search logic
                              print("Searching for: $value");
                            },
                          ),

                        ),
                  ),
                  SizedBox(height: height * 0.01),

                  // SIDEBAR ITEMS
                  Expanded( // ✅ Ensures the list takes the remaining space
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSidebarItem(Icons.home_outlined, "Home", () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }),
                          _buildManageUserTile(),
                          _buildSidebarItem(Icons.local_fire_department_outlined, "Tokens", () {}),
                          _buildSidebarItem(Icons.trending_up_sharp, "Statistics", () {}),
                          _buildSidebarItem(Icons.headset_mic, "Support & Report", () {}),
                          _buildSidebarItem(Icons.ad_units, "Third Party Adds", () {}),
                          _buildSidebarItem(Icons.local_offer_outlined, "Promo & Offers", () {}),
                          _buildSidebarItem(Icons.bolt, "Boosts", () {}),

                           SizedBox(height: height*0.16,),
                          _buildSidebarItem(Icons.check_box_outline_blank, "Admin Name", () {}),
                          _buildSidebarItem(Icons.settings_outlined, "Settings", () {}),
                          _buildSidebarItem(Icons.logout, "Log out", () {}),




                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      }
    );
  }


  Widget _buildSidebarItem(IconData icon, String title,
      VoidCallback onTap) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0), // ✅ Reduces space
      child: ListTile(
        leading: Icon(icon,size: height*0.03, color: Mymatethemes.sidemenutextcolor.withOpacity(0.5)),
        title: Text(
          title,
          style: TextStyle(color: Mymatethemes.sidemenutextcolor,fontWeight: FontWeight.w500,
               fontSize: width*0.01),
        ),
        onTap: onTap,
        dense: true, // ✅ Makes ListTile more compact

      ),
    );
  }

  Widget _buildManageUserTile() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0), // ✅ Reduces space
      child: ExpansionTile(
        title:

        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ManageUsers()));
          },

          child: Row(
            children: [

              Icon(Icons.person_outline_rounded,size:height*0.03, color: Mymatethemes.sidemenutextcolor.withOpacity(0.3)),
              SizedBox(width: width*0.01),
              Text('Users', style: TextStyle(fontSize:width*0.01,color: Mymatethemes.sidemenutextcolor)),
            ],
          ),
        ),
        trailing: Icon(
          isManageUserExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Mymatethemes.sidemenutextcolor,
        ),
        backgroundColor: Mymatethemes.sidemenuColor,
        children: [
          _buildSubSidebarItem("New User",123, () {}),
          _buildSubSidebarItem("Active User",13, () {}),
          _buildSubSidebarItem("Inactive User", 23,() {}),
          _buildCategoryDropdown(),

        ],
        onExpansionChanged: (bool expanded) {
          setState(() {
            isManageUserExpanded = expanded;
          });
        },
        dense: true, // ✅ Makes ListTile more compact

      ),
    );
  }

  Widget _buildSubSidebarItem(String title,int count, Function onPressed) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0), // ✅ Reduces space
      child: ListTile(
        leading: SizedBox(width: width*0.03),
        title:Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize:width*0.01,color: Mymatethemes.sidemenutextcolor.withOpacity(0.8),fontWeight: FontWeight.normal),
            ),
            SizedBox(width: width*0.03),

            Text(
              '$count' ,
              style: TextStyle(fontSize:width*0.011,color: Mymatethemes.sidemenutextcolor.withOpacity(0.8),fontWeight: FontWeight.normal),
            ),
          ],
        ),

        dense: true, // ✅ Makes ListTile more compact

        onTap: () => onPressed(),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      leading: SizedBox(width: width*0.028),
        title: DropdownButton<String>(
        value: selectedCategory,
        dropdownColor: Colors.white,
        style: TextStyle(color: Mymatethemes.textcolor),
        underline: Container(),
        // Remove underline
        items: [
          DropdownMenuItem<String>(
            value: "Select Category",
            child: Text(
                " Category", style: TextStyle(fontSize: width*0.011,color:Mymatethemes.sidemenutextcolor.withOpacity(0.8),fontWeight: FontWeight.normal)),
          ),
          DropdownMenuItem<String>(
            value: "Category 1",
            child: Text("Category 1", style: TextStyle(color: Mymatethemes.textcolor)),
          ),
          DropdownMenuItem<String>(
            value: "Category 2",
            child: Text("Category 2", style: TextStyle(color: Mymatethemes.textcolor)),
          ),
          DropdownMenuItem<String>(
            value: "Category 3",
            child: Text("Category 3", style: TextStyle(color: Mymatethemes.textcolor)),
          ),
          // Add Category option
          DropdownMenuItem<String>(
            value: "Add Category",
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.grey),
                SizedBox(width: width*0.01),
                Text("Add Category", style: TextStyle(color:Mymatethemes.textcolor)),
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
        icon: Icon(Icons.arrow_drop_down, color: Mymatethemes.textcolor),
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
