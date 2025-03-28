import 'package:flutter/material.dart';
import '../APIs/Userprofile.dart'; // Ensure this file exports fetchUserById

class ExpectationChart extends StatefulWidget {
  final String userId;
  const ExpectationChart({Key? key, required this.userId}) : super(key: key);

  @override
  _ExpectationChartState createState() => _ExpectationChartState();
}

class _ExpectationChartState extends State<ExpectationChart> {
  late Future<Map<String, dynamic>> _userDetails;

  @override
  void initState() {
    super.initState();
    _userDetails = fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Here, we set a fixed height (e.g., 750) to match the other sibling widgets.
    const fixedHeight = 750.0;

    return FutureBuilder<Map<String, dynamic>>(
      future: _userDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          // Assuming userData['expectation'] is a List of expectations.
          List<dynamic> expectationsDynamic = userData['expectation'] ?? [];
          List<String> expectations = expectationsDynamic
              .map((e) => e.toString())
              .toList();
          print('Expectation here is: $expectations');

          return Center(
            child: Container(
              width: screenWidth > 600 ? 568 : screenWidth * 0.9,
              height: fixedHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE6E6E6)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                // Using SingleChildScrollView to ensure scrolling when needed.
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: expectations.map((expectation) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              // Using the expectation text as the hint.
                              hintText: expectation,
                              hintStyle: const TextStyle(
                                color: Color(0xFF6F6F6F),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
