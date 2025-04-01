import 'package:dashboard_my_mate/MymateThemes.dart';
import 'package:flutter/material.dart';

import '../widgets/sidebar_layout.dart';

class PromosOffersScreen extends StatefulWidget {
  @override
  _PromosOffersScreenState createState() => _PromosOffersScreenState();
}

class _PromosOffersScreenState extends State<PromosOffersScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 800;
    final sidebarWidth = isWideScreen ? 250.0 : screenWidth * 0.3;

    return Scaffold(
      backgroundColor: Mymatethemes.backgroundColor,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: sidebarWidth,
            color: Colors.grey.shade200,
            child: SidebarLayout(),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promos and offers",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Divider(thickness: 1),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Mymatethemes.commonbuttonclr,
                        ),
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: PromoCreationForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoCreationForm extends StatefulWidget {
  @override
  _PromoCreationFormState createState() => _PromoCreationFormState();
}

class _PromoCreationFormState extends State<PromoCreationForm> {
  bool isTimeBased = true;
  bool isBoosted = true;

  String selectedAvailableFor = "all";

  List<String> categories = ["Category 1", "Category 2", "Category 3"];

  final List<Map<String, dynamic>> _newUsers = [
    {'name': '@User #4563', 'selected': false},
    {'name': '@User #4564', 'selected': false},
    {'name': '@User #4565', 'selected': false},
  ];

  final List<Map<String, dynamic>> _subscribedUsers = [
    {'name': '@User #7890', 'selected': false},
    {'name': '@User #7891', 'selected': false},
    {'name': '@User #7892', 'selected': false},
  ];

  final TextEditingController _subscribedSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final formWidth = constraints.maxWidth > 720
            ? 720.0
            : constraints.maxWidth * 0.95;

        return Center(
          child: Container(
            width: formWidth,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Mymatethemes.backgroundColor,
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTabButton(
                      text: "Time Based",
                      isSelected: isTimeBased,
                      onTap: () => setState(() => isTimeBased = true),
                      isLeftTab: true,
                      isRightTab: false,
                    ),
                    _buildTabButton(
                      text: "User Based",
                      isSelected: !isTimeBased,
                      onTap: () => setState(() => isTimeBased = false),
                      isLeftTab: false,
                      isRightTab: true,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) {
                      final useRow = boxConstraints.maxWidth > 600;
                      if (useRow) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildLeftSection()),
                            Container(
                              width: 1,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.grey.shade300,
                            ),
                            Expanded(child: _buildRightSection()),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLeftSection(),
                            SizedBox(height: 16),
                            Divider(thickness: 1, color: Colors.grey.shade300),
                            SizedBox(height: 16),
                            _buildRightSection(),
                          ],
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available For",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildAvailableForButton("Add all users", "all"),
                          _buildAvailableForButton("Add by category", "category"),
                          _buildAvailableForButton("Add new users", "new"),
                          _buildAvailableForButton(
                              "Add subscribed users", "subscribed"),
                        ],
                      ),

                      if (selectedAvailableFor == "category") ...[
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: categories.map((cat) {
                            return ElevatedButton(
                              onPressed: () {
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Mymatethemes.tabclrunselected,
                                foregroundColor: Colors.black,
                              ),
                              child: Text(cat),
                            );
                          }).toList(),
                        ),
                      ],

                      if (selectedAvailableFor == "new") ...[
                        SizedBox(height: 8),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Mymatethemes.tabclrunselected,
                              foregroundColor: Colors.black,
                            ),
                            child: Text("Add new user"),
                          ),
                        ),
                        SizedBox(height: 12),
                        ..._newUsers.map((user) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: user['selected'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    user['selected'] = value!;
                                  });
                                },
                              ),
                              Text(user['name']),
                            ],
                          );
                        }).toList(),
                      ],

                      if (selectedAvailableFor == "subscribed") ...[
                        SizedBox(height: 12),
                        TextField(
                          controller: _subscribedSearchController,
                          decoration: InputDecoration(
                            hintText: "Search subscribed users",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        SizedBox(height: 12),
                        ..._subscribedUsers.map((user) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: user['selected'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    user['selected'] = value!;
                                  });
                                },
                              ),
                              Text(user['name']),
                            ],
                          );
                        }).toList(),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Mymatethemes.tabclr,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  ),
                  child: Text("Create Promo", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeftSection() {
    if (isTimeBased) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldsRow("Duration", "From", "To"),
          _buildTextFieldsRow("Time", "From", "To"),
          _buildSingleFieldRow("Time remaining", "1 Days | 0 Hours"),
          _buildPriceRow(),
          _buildSingleFieldRow("No of Tokens", "30"),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSingleFieldRow("Users", "Enter Users"),
          _buildSingleFieldRow("Users remaining", "Enter Remaining"),
          _buildPriceRow(),
          _buildSingleFieldRow("No of Tokens", "30"),
        ],
      );
    }
  }


  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Boost toggle
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildToggleButton("Boosted", isBoosted, () {
              setState(() => isBoosted = true);
            }),
            _buildToggleButton("Super Boosted", !isBoosted, () {
              setState(() => isBoosted = false);
            }),
          ],
        ),
        SizedBox(height: 16),
        _buildSingleFieldRow("Free priority match suggestions", "1 Days | 0 Hours"),
        _buildSingleFieldRow("Free priority searches", "1 Days | 0 Hours"),
        _buildSingleFieldRow("Free priority explore", "1 Days | 0 Hours"),
      ],
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isLeftTab,
    required bool isRightTab,
  }) {
    final double radius = 8.0;
    BorderRadius borderRadius;
    if (isLeftTab) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );
    } else if (isRightTab) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );
    } else {
      borderRadius = BorderRadius.circular(radius); // fallback
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Mymatethemes.tabclr : Mymatethemes.tabclrunselected,
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Mymatethemes.tabclr : Mymatethemes.tabclrunselected,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildAvailableForButton(String text, String value) {
    final bool isSelected = (selectedAvailableFor == value);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedAvailableFor = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Mymatethemes.tabclr : Mymatethemes.tabclrunselected,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      child: Text(text),
    );
  }

  Widget _buildTextFieldsRow(String label, String hint1, String hint2) {
    const double labelWidth = 120.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed-width label
          Container(
            width: labelWidth,
            child: Text(label),
          ),
          // The text fields
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildTextField(hint1)),
                SizedBox(width: 10),
                Expanded(child: _buildTextField(hint2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleFieldRow(String label, String hint) {
    const double labelWidth = 120.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed-width label
          Container(
            width: labelWidth,
            child: Text(label),
          ),
          // The text field
          Expanded(
            child: _buildTextField(hint),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow() {
    const double labelWidth = 120.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: labelWidth,
            child: Text("Price"),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildTextField("10 \$")),
                SizedBox(width: 10),
                Expanded(child: _buildTextField("3000 LKR")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }
}
