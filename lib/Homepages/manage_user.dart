import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_my_mate/users_details/about_me.dart';
import 'package:dashboard_my_mate/users_details/more_about_me.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:dashboard_my_mate/widgets/subscriberschart.dart';
import 'package:dashboard_my_mate/widgets/usertype_graph.dart';
import 'package:flutter/material.dart';

import '../dbconnection/firebase.dart';

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
      final counts = await _firebaseService.fetchCounts();
      setState(() {
        activeCount = counts['Active'] ?? 0;
        inactiveCount = counts['inactive'] ?? 0;
        subscribedCount = counts['subscribed'] ?? 0;
        unsubscribedCount = counts['unsubscribed'] ?? 0;
      });
    } catch (e) {
      print('Error fetching counts: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('client').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final personalDetails = data['personalDetails'] ?? {};
        final usertype = data['user_type'] ?? {};


        return {
          'id': doc.id,
          'full_name': personalDetails['full_name'] ?? 'N/A',
          'user_type': data['user type'] ?? 'N/A',
          'rank_no': data['Rank no']?.toString() ?? 'N/A',
          'rank_type': data['Rank type'] ?? 'N/A',
<<<<<<< HEAD
          'active': usertype['status'] ?? false,
=======
          'active': data['status'] ?? false,
>>>>>>> 552f6141f56836b3c1e285457b040047181fc901
        };
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];

    }
  }



  Color _getStatusColor(String user_type) {
    switch (user_type.toLowerCase()) {
      case 'premium':
        return Colors.red;
      case 'basic':
        return Colors.blue;
      case 'standard':
        return Colors.green;
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
                                icon: Icon(Icons.tune),
                                label: Text('Customize'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.settings),
                                label: Text('Settings'),
                              ),
                              Container(
                                width: 1, // Width of the vertical border
                                height: 30, // Adjustable height
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.grey, // Border color
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
                              icon: Icon(Icons.add),
                              label: Text('Add New User'),
                            ),
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
                          child: Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: selectedRows.isNotEmpty ? () {} : null,
                          child: Text('Add To'),
                        ),
                        ElevatedButton(
                          onPressed: selectedRows.isNotEmpty ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(1, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Change Status",
                              style: TextStyle(fontSize: 16, color: selectedRows.isNotEmpty ? Colors.deepPurple : Colors.grey),
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
                                future: _fetchUsers(),
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
                                          final isSelected = selectedRows.contains(user['id']);
                                          return DataRow(
                                            selected: isSelected,
                                            onSelectChanged: (selected) {
                                              setState(() {
                                                if (selected == true) {
                                                  selectedRows.add(user['id'] as String);
                                                } else {
                                                  selectedRows.remove(user['id']);
                                                }
                                              });
                                            },
                                            cells: [
                                              DataCell(
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigate to the user details page
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => moreaboutmeWidget(userId: user['id'] as String),
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
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataCell(Text(user['rank_no'])),
                                              DataCell(Text(user['rank_type'])),
                                              DataCell(
                                                Icon(
                                                  user['active'] ? Icons.check_circle : Icons.cancel,
                                                  color: user['active'] ? Colors.green : Colors.red,
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
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton(String label, int count, Color color) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('$label ($count)', style: TextStyle(color: color)),
    );
  }
}