import 'package:flutter/material.dart';

void main() {
  runApp(const UserdetailsWidget());
}

class User {
  final String name;
  final int age;
  final String dateOfBirth;
  final String occupation;
  final String address;
  final String education;
  final String height;
  final String religion;
  final String caste;
  final String mothersName;
  final String contact;
  final int noOfSiblings;

  User({
    required this.name,
    required this.age,
    required this.dateOfBirth,
    required this.occupation,
    required this.address,
    required this.education,
    required this.height,
    required this.religion,
    required this.caste,
    required this.mothersName,
    required this.contact,
    required this.noOfSiblings,
  });
}

final user = User(
  name: 'John Doe',
  age: 28,
  dateOfBirth: '1996-01-01',
  occupation: 'Software Engineer',
  address: '123 Main St, Anytown',
  education: 'B.Sc. Computer Science',
  height: '5\'10"',
  religion: 'Christianity',
  caste: 'General',
  mothersName: 'Jane Doe',
  contact: '+1234567890',
  noOfSiblings: 2,
);

class UserdetailsWidget extends StatelessWidget {
  const UserdetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double width = MediaQuery.of(context).size.width;

    // Adjust the container size and padding based on the screen width
    double containerWidth = width > 600 ? 546 : width * 0.9;
    double containerHeight = width > 600 ? 748 : width * 1.2;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Container(
            width: containerWidth,
            height: containerHeight,
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
                  _buildRow('Name', user.name),
                  _buildDivider(),
                  _buildRow('Age', '${user.age} years'),
                  _buildDivider(),
                  _buildRow('Date of Birth', user.dateOfBirth),
                  _buildDivider(),
                  _buildRow('Occupation', user.occupation),
                  _buildDivider(),
                  _buildRow('Address', user.address),
                  _buildDivider(),
                  _buildRow('Education', user.education),
                  _buildDivider(),
                  _buildRow('Height', user.height),
                  _buildDivider(),
                  _buildRow('Religion', user.religion),
                  _buildDivider(),
                  _buildRow('Caste', user.caste),
                  _buildDivider(),
                  _buildRow('Mother’s Name', user.mothersName),
                  _buildDivider(),
                  _buildRow('Contact No', user.contact),
                  _buildDivider(),
                  _buildRow('No of Siblings', '${user.noOfSiblings}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildRow(String title, String value) {
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
            value,
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
