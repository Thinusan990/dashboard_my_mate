import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';

import '../widgets/donut_chart.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('clients').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'full_name': data['full_name'] ?? 'N/A',
          'mobile': data['mobile'] != null ? data['mobile'].toString() : 'N/A',
          'user_type': data['user type'] ?? 'N/A',
        };
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Color _getStatusColor(String userType) {
    switch (userType.toLowerCase()) {
      case 'premium':
        return Colors.red;
      case 'basic':
        return Colors.blue;
      case 'stranded':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(children: [
        // Sidebar
        Expanded(
          flex: 2,
          child: Container(
            color: Color(0xFF555555),
            child: SidebarLayout(),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by Name',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14,),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add new user functionality
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add New User'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: _fetchUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error fetching data'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(child: Text('No users found'));
                            } else {
                              final users = snapshot.data!
                                  .where((user) => user['full_name']
                                      .toLowerCase()
                                      .contains(searchQuery))
                                  .toList();

                              return ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  final user = users[index];
                                  final userTypeColor =
                                      _getStatusColor(user['user_type']);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              user['full_name'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              user['mobile'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: userTypeColor
                                                  .withOpacity(0.2),
                                              border: Border.all(
                                                  color: userTypeColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              user['user_type'],
                                              style: TextStyle(
                                                color: userTypeColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: DonutChart(showPercentage: false,) ,
                            ),
                            Expanded(flex: 4,
                            child: Text("Hello there"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
