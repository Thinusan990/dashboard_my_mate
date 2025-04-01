import 'dart:convert';
import 'package:dashboard_my_mate/Homepages/user_screen.dart';
import 'package:dashboard_my_mate/provider/user_provider.dart';
import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
  List<String> selectedRows = [];
  Map<String, dynamic>? user;

  int currentPage = 0;
  int rowsPerPage = 11;
  int totalPages = 2;
  // int totalPages = (users.length / rowsPerPage).ceil();

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _updateUserStatus(List<String> docIds, String newStatus) async {
    for (String docId in docIds) {
      try {
        final response = await http.put(
          Uri.parse(
              'https://backend.graycorp.io:9000/mymate/api/v1/updateClient'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "docId": docId,
            "userInfo": {
              "user_type": newStatus,
            },
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Status updated successfully for $docId!")),
          );
          setState(() {
            _fetchCounts();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update status for $docId.")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
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
        if (user['active'] == 'Active') {
          active++;
        } else if (user['active'] == 'Inactive') {
          inactive++;
        }

        final userType = user['user_type'].toLowerCase();
        if (userType == 'basic' ||
            userType == 'premium' ||
            userType == 'standard') {
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
    final url = Uri.parse(
        'https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            return Row(
              children: [
                if (!isMobile) Expanded(flex: 2, child: SidebarLayout()),
                Expanded(
                  flex: isMobile ? 1 : 8,
                  child: Container(
                    color: Mymatethemes.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Users',
                            style: TextStyle(
                                color: Mymatethemes.editabletextclr,
                                fontSize: width * 0.015,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8),
                          ),
                          if (!isMobile)
                            Container(
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1.0),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.tune_outlined,
                                              color: Mymatethemes.add_editbtn,
                                              size: height * 0.025,
                                            ),
                                            SizedBox(width: width * 0.005),
                                            Text('Customize',
                                                style: TextStyle(
                                                    color: Mymatethemes
                                                        .add_editbtn,
                                                    fontSize: width * 0.01)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: width * 0.01),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.settings_outlined,
                                              color: Mymatethemes.add_editbtn,
                                              size: height * 0.025,
                                            ),
                                            SizedBox(width: width * 0.005),
                                            Text('Settings',
                                                style: TextStyle(
                                                    color: Mymatethemes
                                                        .add_editbtn,
                                                    fontSize: width * 0.01)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: width * 0.001,
                                    height: height * 0.024,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                    height: height * 0.065,
                                    child: TextField(
                                      controller: searchController,
                                      style: TextStyle(
                                          color: Mymatethemes.add_editbtn
                                              .withOpacity(0.8),
                                          fontSize: width * 0.011),
                                      onChanged: (value) {
                                        setState(() {
                                          searchQuery = value.toLowerCase();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            color: Mymatethemes.add_editbtn
                                                .withOpacity(0.5),
                                            fontSize: width * 0.011),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: height * 0.025,
                                          color: Mymatethemes.add_editbtn
                                              .withOpacity(0.7),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.01),
                                          borderSide: BorderSide(
                                            color: Mymatethemes
                                                .sidemenutextcolor
                                                .withOpacity(0.05),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: width * 0.02,
                                            vertical: height * 0.01),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.01),
                                ],
                              ),
                            ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1.0),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.005,
                                horizontal: width * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildCountButton(
                                    'Active', activeCount, Colors.black),
                                _buildCountButton(
                                    'Inactive', inactiveCount, Colors.black),
                                _buildCountButton('Subscribed', subscribedCount,
                                    Colors.black),
                                _buildCountButton('Non-subscribed',
                                    unsubscribedCount, Colors.black),
                                if (!isMobile)
                                  _buildCountButton(
                                      'Suspended', 123, Colors.black),
                                if (!isMobile)
                                  _buildCountButton(
                                      'Banned', 123, Colors.black),
                                if (!isMobile)
                                  _buildCountButton(
                                      'New User', 123, Colors.black),
                                Container(
                                  width: width * 0.001,
                                  height: height * 0.024,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                if (!isMobile)
                                  Container(
                                    height: height * 0.04,
                                    width: width * 0.09,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Mymatethemes.sidemenutextcolor
                                              .withOpacity(0.1)),
                                      borderRadius:
                                          BorderRadius.circular(width * 0.003),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: userProvider.hasPermission("add")
                                        ? () {
                                      }
                                      :null,
                                      child: Text('+ Add New User',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.008)),
                                      style:
                                          CommonButtonStyle.commonButtonStyle(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          // Action Buttons – enabled when selectedRows is not empty
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Delete button
                              Container(
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Mymatethemes.sidemenutextcolor
                                          .withOpacity(0.2)),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.002),
                                ),
                                child: ElevatedButton(
                                  onPressed: selectedRows.isNotEmpty && 
                                    userProvider.hasPermission("delete")
                                      ? () {
                                          // Your delete action here
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedRows.isNotEmpty &&
                                        userProvider.hasPermission("delete")
                                        ? Colors.white
                                        : Mymatethemes.commonbuttonclr,
                                    foregroundColor: selectedRows.isNotEmpty &&
                                        userProvider.hasPermission("delete")
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(width * 0.002)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: width * 0.01),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(fontSize: width * 0.0085),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.01),
                              // "Add to" Dropdown button
                              Container(
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Mymatethemes.sidemenutextcolor
                                          .withOpacity(0.2)),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.002),
                                ),
                                child: ElevatedButton(
                                  onPressed:
                                      selectedRows.isNotEmpty ? () {} : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedRows.isNotEmpty
                                        ? Mymatethemes.commonbuttonclr
                                        : Colors.grey.shade300,
                                    foregroundColor: selectedRows.isNotEmpty
                                        ? Colors.black
                                        : Colors.black38,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            width * 0.002)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.01,
                                        vertical: height * 0.01),
                                  ),
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      "Add to",
                                      style: TextStyle(
                                          fontSize: width * 0.0085,
                                          color: selectedRows.isNotEmpty
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                    underline: SizedBox(
                                      width: 0.1,
                                    ),
                                    onChanged: selectedRows.isNotEmpty
                                        ? (value) async {
                                            if (value != null) {
                                              await _updateUserStatus(
                                                  selectedRows, value);
                                            }
                                          }
                                        : null,
                                    items: [
                                      "Category1",
                                      "Category2",
                                      "Category3",
                                      "Category4"
                                    ]
                                        .map(
                                          (status) => DropdownMenuItem<String>(
                                            value: status.toLowerCase(),
                                            child: Text(status),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.01),
                              // "Change Status" Dropdown button
                              Container(
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                  border: selectedRows.isNotEmpty
                                      ? Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  )
                                      : null,
                                  color: selectedRows.isNotEmpty &&
                                      userProvider.hasPermission("changeType")
                                      ? Mymatethemes.commonbuttonclr
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(width * 0.002),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.01, vertical: height * 0.002),
                                child: DropdownButton<String>(
                                  hint: Text(
                                    "Change Status",
                                    style: TextStyle(
                                        fontSize: width * 0.0085,
                                        color: selectedRows.isNotEmpty &&
                                            userProvider.hasPermission("changeType")
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                  underline: SizedBox(),
                                  onChanged: selectedRows.isNotEmpty &&
                                      userProvider.hasPermission("changeType")
                                      ? (value) async {
                                    if (value != null) {
                                      await _updateUserStatus(selectedRows, value);
                                    }
                                  }
                                      : null,
                                  items: [
                                    "Basic",
                                    "Standard",
                                    "Premium",
                                    "Unsubscribed"
                                  ]
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
                          SizedBox(height: height * 0.05),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: isMobile ? 1 : 2,
                                  child: Container(
                                    height: height * 0.8,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Mymatethemes.add_editbtn
                                              .withOpacity(0.2),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: FutureBuilder<
                                        List<Map<String, dynamic>>>(
                                      future: _fetchUserProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child:
                                                  Text('Error fetching data'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Center(
                                              child: Text('No users found'));
                                        } else {
                                          final users = snapshot.data!
                                              .where((user) => user['full_name']
                                                  .toLowerCase()
                                                  .contains(searchQuery))
                                              .toList();
                                          final visibleUsers = users
                                              .skip(currentPage * rowsPerPage)
                                              .take(rowsPerPage)
                                              .toList();

                                          return SingleChildScrollView(
                                              child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              dividerThickness: 0.01,
                                              headingRowHeight: height * 0.09,
                                              dataRowHeight: height * 0.05,
                                              columns: [
                                                DataColumn(
                                                    label: Text('',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                DataColumn(
                                                    label: Text('Username',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                DataColumn(
                                                    label: Text('Status',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                DataColumn(
                                                    label: Text('Rank No',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                DataColumn(
                                                    label: Text('Rank Type',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                DataColumn(
                                                    label: Text('Active',
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                              ],
                                              rows: visibleUsers.map((user) {
                                                final userTypeColor =
                                                    _getStatusColor(
                                                        user['user_type']);
                                                final isSelected = selectedRows
                                                    .contains(user['id']);
                                                return DataRow(
                                                  cells: [
                                                    DataCell(
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Use parent's setState to update global state
                                                          setState(() {
                                                            if (selectedRows
                                                                .contains(user[
                                                                    'id'])) {
                                                              selectedRows
                                                                  .remove(user[
                                                                      'id']);
                                                            } else {
                                                              selectedRows.add(
                                                                  user['id']);
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          width: width * 0.01,
                                                          height:
                                                              height * 0.023,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                              color: Mymatethemes
                                                                  .add_editbtn
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                            color: isSelected
                                                                ? Mymatethemes
                                                                    .add_editbtn
                                                                : Colors.white,
                                                          ),
                                                          child: isSelected
                                                              ? Icon(
                                                                  Icons.check,
                                                                  size: width *
                                                                      0.006,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UserScreen(
                                                                        userId: user['id']
                                                                            as String)),
                                                          );
                                                        },
                                                        child: Text(
                                                            user['full_name'],
                                                            style: TextStyle(
                                                                color: Mymatethemes
                                                                    .editabletextclr
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    width *
                                                                        0.008)),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02,
                                                                vertical:
                                                                    height *
                                                                        0.003),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: userTypeColor
                                                              .withOpacity(
                                                                  0.07),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                            user['user_type'],
                                                            style: TextStyle(
                                                                color:
                                                                    userTypeColor,
                                                                fontSize:
                                                                    width *
                                                                        0.008)),
                                                      ),
                                                    ),
                                                    DataCell(Text(
                                                        user['rank_no'],
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: width *
                                                                0.008))),
                                                    DataCell(Text(
                                                        user['rank_type'],
                                                        style: TextStyle(
                                                            color: Mymatethemes
                                                                .editabletextclr
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: width *
                                                                0.008))),
                                                    DataCell(
                                                      Icon(
                                                        user['active'] ==
                                                                'Active'
                                                            ? Icons.circle
                                                            : Icons
                                                                .circle_outlined,
                                                        color: user['active'] ==
                                                                'Active'
                                                            ? Colors.green
                                                            : Color(0xFFE9E9E9),
                                                        size: width * 0.007,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          ));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                if (!isMobile)
                                  Expanded(flex: 1, child: Subscriberschart()),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Filter : 000',
                                  style: TextStyle(
                                      color: Mymatethemes.add_editbtn
                                          .withOpacity(0.5),
                                      fontSize: width * 0.0085)),
                              SizedBox(width: width * 0.335),
                              Text('Pages',
                                  style: TextStyle(
                                      color: Mymatethemes.add_editbtn
                                          .withOpacity(0.5),
                                      fontSize: width * 0.0085)),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: width * 0.008,
                                  color:
                                      Mymatethemes.add_editbtn.withOpacity(0.5),
                                ),
                                onPressed: currentPage > 0
                                    ? () {
                                        setState(() {
                                          currentPage--;
                                        });
                                      }
                                    : null,
                              ),
                              Container(
                                height: height * 0.028,
                                width: width * 0.02,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Mymatethemes.add_editbtn
                                        .withOpacity(0.5),
                                  ),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.002),
                                ),
                                child: Center(
                                    child: Text(' ${currentPage + 1}',
                                        style: TextStyle(
                                            color: Mymatethemes.add_editbtn,
                                            fontSize: width * 0.008))),
                              ),
                              SizedBox(width: width * 0.01),
                              Text('of',
                                  style: TextStyle(
                                      color: Mymatethemes.add_editbtn
                                          .withOpacity(0.5),
                                      fontSize: width * 0.0085)),
                              SizedBox(width: width * 0.01),
                              Container(
                                height: height * 0.028,
                                width: width * 0.02,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Mymatethemes.add_editbtn
                                        .withOpacity(0.5),
                                  ),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.002),
                                ),
                                child: Center(
                                    child: Text(' $totalPages',
                                        style: TextStyle(
                                            color: Mymatethemes.add_editbtn,
                                            fontSize: width * 0.008))),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: width * 0.008,
                                  color:
                                      Mymatethemes.add_editbtn.withOpacity(0.5),
                                ),
                                onPressed: currentPage < totalPages - 1
                                    ? () {
                                        setState(() {
                                          currentPage++;
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCountButton(String label, int count, Color color) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.03,
      width: width * 0.09,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Mymatethemes.add_editbtn.withOpacity(0.3), width: 0.5),
        borderRadius: BorderRadius.circular(width * 0.01),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.003, vertical: height * 0.002),
        child: Text('$label ($count)',
            style: TextStyle(
                color: Mymatethemes.add_editbtn, fontSize: width * 0.008)),
      ),
    );
  }
}
