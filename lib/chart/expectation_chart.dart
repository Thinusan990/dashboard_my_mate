import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Expectationchart(),
      ),
    );
  }
}

class Expectationchart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: screenWidth > 600 ? 568 : screenWidth * 0.9,
        height: 738,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Removed the heading Text('Expectation', ...)
              SizedBox(height: 20), // Optional: Add spacing if needed
              ...List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    height: 40, // Set desired height
                    width: double.infinity, // Set desired width
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFE6E6E6)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Expectation ${index + 1}',
                        hintStyle: TextStyle(
                          color: Color(0xFF6F6F6F),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
