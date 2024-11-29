import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dbconnection/firebase.dart';

class UserdetailsWidget extends StatefulWidget {
  final String userId;

  const UserdetailsWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _UserdetailsWidgetState createState() => _UserdetailsWidgetState();
}

class _UserdetailsWidgetState extends State<UserdetailsWidget> {
  late Future<Map<String, dynamic>> _userDetails;

  @override
  void initState() {
    super.initState();
    _userDetails = FirebaseService().fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _userDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;
                return Container(
                  width: 550,
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
                        _buildRow('Name', userData['full_name'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Age', userData['age'] != null ? '${userData['age']}' : 'N/A'),
                    _buildDivider(),
                    _buildRow('Date of Birth', userData['date_of_birth'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Occupation', userData['occupation'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Address', userData['address'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Education', userData['education'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Height', userData['height'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Religion', userData['religion'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Caste', userData['caste'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Mother’s Name', userData['mothers_name'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('Contact No', userData['contact'] ?? 'N/A'),
                    _buildDivider(),
                    _buildRow('No of Siblings', userData['no_of_siblings'] != null ? '${userData['no_of_siblings']}' : 'N/A'),
                    ],
                    ),
                  ),
                );
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, dynamic value) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
            value!= null ? value.toString() : 'N/A',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.19,
              color: Color(0xFF6F6F6F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFFE6E6E6),
      thickness: 1.0,
      height: 16,
    );
  }
}
