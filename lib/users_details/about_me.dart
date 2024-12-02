import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dbconnection/firebase.dart';

class aboutmeWidget extends StatefulWidget {
  final String userId;

  const aboutmeWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _aboutmeWidgetState createState() => _aboutmeWidgetState();
}

class _aboutmeWidgetState extends State<aboutmeWidget> {
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: ListView(
                      children: [
                        _buildRow(
                            'Age',
                            userData['age'] != null
                                ? '${userData['age']}'
                                : 'N/A'),
                        _buildRow('Date of Birth',
                            userData['date_of_birth'] ?? 'N/A'),
                        _buildRow(
                            'Occupation', userData['occupation'] ?? 'N/A'),
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
                fontSize: 16,
                height: 1.19,
                color: Color(0xFF6F6F6F),
              ),
            ),


                Container(
                     width: 300,
                     height: 50,
                      padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                     decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border.all(color: Color(0xFFE6E6E6)), // Border color
                     borderRadius: BorderRadius.circular(5), // Rounded corners
                       ),
                     child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                       child: Text(
                       value != null ? value.toString() : 'N/A',
                       style: const TextStyle(
                       fontFamily: 'Inter',
                       fontWeight: FontWeight.w400,
                       fontSize: 16,
                       color: Color(0xFF6F6F6F),
                    ),
                  ),
                )),
          ]),
        ));
  }
}
