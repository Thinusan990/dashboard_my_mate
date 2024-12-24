import 'package:dashboard_my_mate/MymateThemes.dart';
import 'package:flutter/material.dart';

class PackagepromoWidget extends StatefulWidget {
  @override
  _PackagepromoWidgetState createState() => _PackagepromoWidgetState();
}

class _PackagepromoWidgetState extends State<PackagepromoWidget> {
  int _selectedOuterTab = 0;
  int _selectedInnerTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
            color: Mymatethemes.backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                left: 50,
                top: 0,
                bottom: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.centerLeft, // Keeps the container aligned to the left
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 1100, // Set the desired reduced width here
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                        topLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                        color: Mymatethemes.backgroundColor,
                      ),
                      child: Column(
                        children: [
                          // Inner Tabs: Time Based, User Based
                          Row(
                            children: [
                              _buildInnerTab("Time Based", 0),
                              _buildInnerTab("User Based", 1),
                            ],
                          ),

                          // Dynamic Content
                          Expanded(
                            child: _selectedInnerTab == 0
                                ? _buildTimeBasedFields()
                                : _buildUserBasedFields(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              Positioned(
                left: 25, // Adjust positioning
                top: 17, // Fine-tune vertical positioning
                child: Column(
                  children: [
                    _buildRotatedOuterTab("Basic", 0,Color(0xFFF6F6F6),Mymatethemes.basic),
                    _buildRotatedOuterTab("Standard", 1,Color(0xFFF6F6F6),Mymatethemes.standard),
                    _buildRotatedOuterTab("Premium", 2,Color(0xFFFFF5F4),Mymatethemes.premium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRotatedOuterTab(String title, int index, Color unselectedcolor,Color Textclr) {
    bool isSelected = _selectedOuterTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedOuterTab = index),
      child: Container(

        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey.shade300 : unselectedcolor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0)
              ),



              border: Border(

                bottom: BorderSide(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
            ),

            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Textclr,

              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInnerTab(String title, int index) {
    bool isSelected = _selectedInnerTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedInnerTab = index),
      child: Container(
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBasedFields() {
    return SingleChildScrollView(
      child: IntrinsicHeight( // Ensures proper vertical alignment and height for the divider
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to match the tallest widget
          children: [
            // Left Column
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  _buildRow('Duration', ['From', 'To']),
                  _buildRow('Time', ['From', 'To']),
                  _buildTimeRemainingRow('Time Remaining'),
                  _buildRowWithValues(
                      'Price', ['10\$', '3000 LKR'], ['Worldwide', 'Sri Lanka']),
                  _buildRow('New Price', ['Worldwide', 'Sri Lanka']),
                  _buildRow('No of Tokens', ['30']),
                  _buildRow('New No of Tokens', ['']),
                ],
              ),
            ),
            SizedBox(width: 10,),
            VerticalDivider(
              thickness: 1,
              width: 1, // Ensure it has a visible width
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Row(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Boosted'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Super Boosted'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                  _buildRightSection('Free priority match suggestions'),
                  _buildRightSection('Free priority searches'),
                  _buildRightSection('Free priority explore'),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Create Promo',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserBasedFields() {
    return SingleChildScrollView(
      child: IntrinsicHeight( // Ensures proper vertical alignment and height for the divider
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to match the tallest widget
          children: [
            // Left Column
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  _buildRow('Total Users', ['']),
                  _buildRow('Remaining Users', ['']),
                  _buildTimeRemainingRow('Time Remaining'),
                  _buildRowWithValues(
                      'Price', ['10\$', '3000 LKR'], ['Worldwide', 'Sri Lanka']),
                  _buildRow('New Price', ['Worldwide', 'Sri Lanka']),
                  _buildRow('No of Tokens', ['30']),
                  _buildRow('New No of Tokens', ['']),
                ],
              ),
            ),
            SizedBox(width: 10,),
            VerticalDivider(
              thickness: 1,
              width: 1, // Ensure it has a visible width
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Boosted'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Super Boosted'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  _buildRightSection('Free priority match suggestions'),
                  _buildRightSection('Free priority searches'),
                  _buildRightSection('Free priority explore'),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Create Promo',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, List<String> placeholders) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Row(
            children: placeholders
                .map((placeholder) =>
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: _buildtextBox('', placeholder),
                ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRemainingRow(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Row(
            children: [
              _buildtextBox('000', 'Days'),
              SizedBox(width: 6),
              _buildtextBox('00', 'Hrs'),
              SizedBox(width: 6),
              _buildtextBox('00', 'Mns'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithValues(String title, List<String> values,
      List<String> labels) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Row(
            children: [
              _buildtextBox(values[0], labels[0]),
              SizedBox(width: 6),
              _buildtextBox(values[1], labels[1]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
                Spacer(),
              _buildtextBox('1', 'Days'),
              SizedBox(width: 6),
              _buildtextBox('0', 'Hours'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('New', style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(width: 8),
              _buildtextBox('', 'Days'),
              SizedBox(width: 6),
              _buildtextBox('', 'Hours'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildtextBox(String value, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}