import 'dart:convert';

import 'package:dashboard_my_mate/Homepages/user_screen.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../MymateThemes.dart';
import '../dbconnection/firebase.dart';
import '../widgets/subscriberschart.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  int activeCount = 0;
  int inactiveCount = 0;
  int subscribedCount = 0;
  int unsubscribedCount = 0;
  Set<String> selectedRows = {};
  final FirebaseService _firebaseService = FirebaseService();
  Map<String, dynamic>? user;



  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _updateUserStatus(Set<String> userIds, String newStatus) async {
    try {
      for (String userId in userIds) {
        await _firebaseService.updateUser(userId, {'user type': newStatus});
      }
      setState(() {
        selectedRows.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User status updated to $newStatus")),
      );
      _fetchCounts();
    } catch (e) {
      print("Error updating user status: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating user status")),
      );
    }
  }

  Future<void> _fetchCounts() async {
    try {
      final users = await _fetchUserProfile();
      int active = 0;
      int inactive = 0;
      int subscribed = 0;
      int unsubscribed = 0;

      for (var user in users) {
        // Count Active and Inactive users
        if (user['active'] == 'Active') {
          active++;
        } else if (user['active'] == 'Inactive') {
          inactive++;
        }

        final userType = user['user_type'].toLowerCase();
        if (userType == 'basic' || userType == 'premium' || userType == 'standard') {
          subscribed++;
        } else {
          unsubscribed++;
        }
      }

      setState(() {
        activeCount = active;
        inactiveCount = inactive;
        subscribedCount = subscribed;
        unsubscribedCount = unsubscribed;
      });
    } catch (error) {
      print('Error fetching counts: $error');
    }
  }


  Future<List<Map<String, dynamic>>> _fetchUserProfile() async {
    final url = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');

        final List<dynamic> data = jsonDecode(response.body);
        return data.map((user) {
          return {
            'id': user['docId'] ?? 'N/A',
            'full_name': user['personalDetails']?['full_name'] ?? 'N/A',
            'user_type': user['userInfo']?['user_type'] ?? 'N/A',
            'rank_no': user['Rank no']?.toString() ?? 'N/A',
            'rank_type': user['Rank type'] ?? 'N/A',
            'active': user['userInfo']?['status'] ?? 'Inactive',
          };
        }).toList();
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw Exception('Failed to load user profile');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
      return [];
    }
  }



  Color _getStatusColor(String user_type) {
    switch (user_type.toLowerCase()) {
      case 'premium':
        return Mymatethemes.premium;
      case 'basic':
        return Mymatethemes.basic;
      case 'standard':
        return Mymatethemes.standard;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SidebarLayout(),
            ),
            Expanded(

              flex: 8,
              child: Container(
                color: Mymatethemes.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Users',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey, width: 1.0),
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.tune,
                                    color: Mymatethemes.textcolor,
                                  ),
                                  label: Text('Customize',
                                      style: TextStyle(color: Mymatethemes.textcolor)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:Mymatethemes.commonbuttonclr
                                  ),
                                ),
                                ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.settings,
                                      color: Mymatethemes.textcolor,
                                    ),
                                    label: Text('Settings',
                                        style: TextStyle(color: Mymatethemes.textcolor)
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:Mymatethemes.commonbuttonclr
                                    )),
                                Container(
                                  width: 1,
                                  height: 30,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 4, height: 5),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value.toLowerCase();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCountButton('Active', activeCount, Colors.black),
                            _buildCountButton('Inactive', inactiveCount, Colors.black),
                            _buildCountButton('Subscribed', subscribedCount, Colors.black),
                            _buildCountButton('Unsubscribed', unsubscribedCount, Colors.black),
                            _buildCountButton('Suspended', 123, Colors.black),
                            _buildCountButton('Banned', 123, Colors.black),
                            _buildCountButton('New User', 123, Colors.black),
                            Spacer(),
                            Container(
                              width: 1,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.add,
                                    color: Mymatethemes.textcolor,
                                  ),
                                  label: Text('Add New User',
                                      style: TextStyle(color: Mymatethemes.textcolor)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:Mymatethemes.commonbuttonclr
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: selectedRows.isNotEmpty ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRows.isNotEmpty
                                  ? Mymatethemes.commonbuttonclr
                                  : Colors.grey.shade300,
                              foregroundColor: selectedRows.isNotEmpty
                                  ? Colors.black
                                  : Colors.black38,
                            ),
                            child: Text('Delete'
                            ),
                          ),
                          SizedBox(width: 4),

                          ElevatedButton(
                            onPressed: selectedRows.isNotEmpty ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRows.isNotEmpty
                                  ? Mymatethemes.commonbuttonclr
                                  :  Colors.grey.shade300,
                              foregroundColor: selectedRows.isNotEmpty
                                  ? Colors.black
                                  : Colors.black38,

                            ),
                            child: Text('Add To'),
                          ),
                          SizedBox(width: 4),
                          Container(
                            height: 30,
                            width: 145,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: selectedRows.isNotEmpty
                                  ? Mymatethemes.commonbuttonclr
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),

                              // ),
                            ),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Change Status",
                                style: TextStyle(fontSize: 14, color: selectedRows.isNotEmpty ? Colors.black : Colors.grey),
                              ),
                              underline: SizedBox(),
                              onChanged: selectedRows.isNotEmpty
                                  ? (value) async {
                                if (value != null) {
                                  await _updateUserStatus(selectedRows, value);
                                }
                              }
                                  : null,
                              items: ["Basic", "Standard", "Premium", "Unsubscribed"]
                                  .map(
                                    (status) => DropdownMenuItem<String>(
                                  value: status.toLowerCase(),
                                  child: Text(status),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 750,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: FutureBuilder<List<Map<String, dynamic>>>(
                                  future: _fetchUserProfile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('Error fetching data'));
                                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                      return Center(child: Text('No users found'));
                                    } else {
                                      final users = snapshot.data!
                                          .where((user) => user['full_name'].toLowerCase().contains(searchQuery))
                                          .toList();
                                      print(users);
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          headingRowHeight: 50,
                                          dataRowHeight: 40,
                                          columns: [
                                            DataColumn(label: Text('Username')),
                                            DataColumn(label: Text('Status')),
                                            DataColumn(label: Text('Rank No')),
                                            DataColumn(label: Text('Rank Type')),
                                            DataColumn(label: Text('Active')),
                                          ],
                                          rows: users.map((user) {
                                            final userTypeColor = _getStatusColor(user['user_type']);
                                            final isSelected = selectedRows.contains(user['docid']);
                                            return DataRow(
                                              selected: isSelected,
                                              onSelectChanged: (selected) {
                                                setState(() {
                                                  if (selected == true) {
                                                    selectedRows.add(user['docid'] as String);
                                                  } else {
                                                    selectedRows.remove(user['docid']);
                                                  }
                                                });
                                              },
                                              cells: [
                                                DataCell(
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserScreen(userId: user['id'] as String),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(user['full_name']),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: userTypeColor.withOpacity(0.2),
                                                      border: Border.all(color: userTypeColor, width: 0.5),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Text(
                                                      user['user_type'],
                                                      style: TextStyle(
                                                        color: userTypeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Text(user['rank_no'])),
                                                DataCell(Text(user['rank_type'])),
                                                DataCell(
                                                  Icon(
                                                    user['active'] == 'Active' ? Icons.circle : Icons.circle_outlined,
                                                    color: user['active'] == 'Active' ? Colors.green : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),



                                      );

                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Subscriberschart()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton(String label, int count, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:Mymatethemes.commonbuttonclr
      ),

      onPressed: () {},
      child: Text('$label ($count)', style: TextStyle(color: color
      )),

    );
  }
}