import 'package:dashboard_my_mate/widgets/sidebar_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TokensScreen extends StatefulWidget {
  @override
  _TokensScreenState createState() => _TokensScreenState();
}

class _TokensScreenState extends State<TokensScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  int _selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(children: [
      Expanded(
        flex: 2,
        child: SidebarLayout(),
      ),
      Expanded(
        flex: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Tokens',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.tune),
                    label: Text('Customize'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4, height: 5),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  _buildTabButton('Packages', 0),
                  _buildTabButton('Token Charges', 1),
                ],
              ),
            ),
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildPackagesView()
                  : _buildTokenChargesView(),
            ),
          ],
        ),
      )
    ])));
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white70 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.white70,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.grey : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPackagesView() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: GridView.count(
          crossAxisCount: 3, // Three columns
          crossAxisSpacing: 12.0, // Horizontal space between cards
          mainAxisSpacing: 16.0, // Vertical space between cards
          childAspectRatio:
              0.55, // Adjust for taller cards (less than 1 makes them taller)
          children: [
            _buildTokenCard(
              title: 'Basic',
              titlecolor: Colors.grey,
              priceWorldWide: '10 \$',
              priceLocal: '3000 LKR',
              tokens: '30 ',
              color: Colors.white70,
              matchDays: '1',
              matchHours: '0',
              searchDays: '1',
              searchHours: '0',
              exploreDays: '1',
              exploreHours: '0',
            ),
            _buildTokenCard(
              title: 'Standard',
              titlecolor: Colors.green,
              priceWorldWide: '15 \$',
              priceLocal: '4500 LKR',
              tokens: '50 ',
              color: Colors.white70,
              matchDays: '3',
              matchHours: '0',
              searchDays: '3',
              searchHours: '0',
              exploreDays: '3',
              exploreHours: '0',
            ),
            _buildTokenCard(
              title: 'Premium',
              titlecolor: Colors.redAccent,
              priceWorldWide: '20 \$',
              priceLocal: '6000 LKR',
              tokens: '80 ',
              color: Colors.white70,
              matchDays: '7',
              matchHours: '0',
              searchDays: '7',
              searchHours: '0',
              exploreDays: '7',
              exploreHours: '0',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenChargesView() {
    return Container(
      height: 800,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTokenChargeRow('Check match ', '2'),
          _buildTokenChargeRow('Send interest', '1'),
          _buildTokenChargeRow('Accept interest', '1'),
          _buildTokenChargeRow('Boost profile', '3'),
          _buildTokenChargeRow('Super Boost Profile', '5'),
          SizedBox(height: 5),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 32.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTokenChargeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // SizedBox(width: 1),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: _buildPriceBox(value, 'Tokens'),
          )),
        ],
      ),
    );
  }

  Widget _buildTokenCard({
    required String title,
    required Color titlecolor,
    required String priceWorldWide,
    required String priceLocal,
    required String tokens,
    required Color color,
    required String matchDays,
    required String matchHours,
    required String searchDays,
    required String searchHours,
    required String exploreDays,
    required String exploreHours,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildPriceBox(priceWorldWide, 'Worldwide'),
                      _buildPriceBox(priceLocal, 'In Sri Lanka'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No of Tokens',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  _buildTokenBox(tokens),
                ],
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 8),
              _buildPrioritySection(
                  'Free priority match suggestions', matchDays, matchHours),
              _buildPrioritySection(
                  'Free priority searches', searchDays, searchHours),
              _buildPrioritySection(
                  'Free priority explore', exploreDays, exploreHours),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -3,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: titlecolor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBox(String price, String label) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Text(
            price,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildTokenBox(String token) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Text(
            token,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildPrioritySection(
    String title,
    String days,
    String hours,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildPriceBox(days, 'days'),
            SizedBox(width: 8),
            _buildPriceBox(hours, 'Hours'),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
