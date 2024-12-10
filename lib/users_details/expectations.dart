import 'package:flutter/material.dart';



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

              SizedBox(height: 20),
              ...List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
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