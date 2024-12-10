import 'package:flutter/material.dart';

class UserpackageWidget extends StatelessWidget {
  const UserpackageWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 390,
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
                      child: SingleChildScrollView(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader("Packages (3)"),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Stranded", "1",
                                color: Color(0xFF34C759)),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Premium", "3",
                                color: Color(0xFFFF3B30)),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Basic", "5",
                                color: Color(0xFF707C8C)),
                            const SizedBox(height: 52, width: 2),
                            _buildHeader("Boosts (2)"),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Boosted", "5",
                                color: Color(0xFF0703F1)),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Super Boosted", "5",
                                color: Color(0xFF0703F1)),
                            const SizedBox(height: 52),
                            _buildHeader("Promotions"),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Promo 1", "2",
                                color: Color(0xFFFFB743)),
                            const SizedBox(height: 16, width: 2),
                            _buildColoredRow("Promo 2", "1",
                                color: Color(0xFFFFB743)),
                          ],
                        ),
                      )))
            ]))));
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF6F6F6F),
      ),
    );
  }

  Widget _buildColoredRow(String title, String count, {required Color color}) {
    return Row(
      children: [
      Expanded(
      child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: color,
          ),
        overflow: TextOverflow.ellipsis,
        ),
      ),
        Container(
          width: 60,
          height: 30,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE6E6E6), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.2,
              color: Color(0xFF6F6F6F),
            ),
          ),
        ),
      ],
    );
  }
}
