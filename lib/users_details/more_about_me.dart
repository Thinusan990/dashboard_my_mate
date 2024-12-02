import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dbconnection/firebase.dart';

class moreaboutmeWidget extends StatefulWidget {
  final String userId;

  const moreaboutmeWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _moreaboutmeWidget createState() => _moreaboutmeWidget();
}

class _moreaboutmeWidget extends State<moreaboutmeWidget> {
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
                        vertical: 32, horizontal: 24),
                    child: ListView(

                      children: [

                        _buildRow('Hobby', userData['hobbies'] != null
                            ? '${userData['hobbies']}'
                            : 'N/A'),
                        _buildRow('Favorites',
                            userData['Favorites'] ?? 'N/A'),
                        _buildRow('Alcohol',
                            userData['alcohol'] ?? 'N/A'),
                        _buildRow('sports', userData['sports'] ?? 'N/A'),
                        _buildRow('cooking', userData['cooking'] ?? 'N/A'),
                        _buildRow('Bio', userData['bio'], isBio: true),
                        _buildPhotoSection('photo', userData['photo'] ?? 'N/A'),

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

  Widget _buildRow(String title, dynamic value, {bool isBio = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                fontSize: 16,
                height: 1.19,
                color: Color(0xFF6F6F6F),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: isBio ? 100 : 50,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE6E6E6)),
                borderRadius: BorderRadius.circular(5),
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
            ),
          ),
          )
        ],
      ),
    );
  }
}
Widget _buildPhotoSection(String title, dynamic photoData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          3,
              (index) => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFFE6E6E6)),
            ),
            child: photoData != null
                ? Image.network(
              photoData,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image, color: Colors.grey[600]),
          ),
        ),
      ),
    ],
  );
}
