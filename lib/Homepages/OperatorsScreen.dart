import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MymateThemes.dart';
import '../widgets/sidebar_layout.dart';

class OperatorsScreen extends StatefulWidget {
  @override
  _OperatorsScreenState createState() => _OperatorsScreenState();
}

class _OperatorsScreenState extends State<OperatorsScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _operatorsData = [
    {
      'selected': false,
      'name': 'Admin user name',
      'id': 'Admin user ID',
      'role': 'Administration users Role',
    },
    {
      'selected': false,
      'name': 'Admin user name',
      'id': 'Admin user ID',
      'role': 'Administration users Role',
    },
    {
      'selected': false,
      'name': 'Admin user name',
      'id': 'Admin user ID',
      'role': 'Administration users Role',
    },
    {
      'selected': false,
      'name': 'Admin user name',
      'id': 'Admin user ID',
      'role': 'Administration users Role',
    },
    {
      'selected': false,
      'name': 'Admin user name',
      'id': 'Admin user ID',
      'role': 'Administration users Role',
    },
  ];

  final List<Map<String, String>> _operatorsRolesRightData = [
    {'name': '# Admin user name', 'id': '# Admin user ID'},
    {'name': '# Admin user name', 'id': '# Admin user ID'},
    {'name': '# Admin user name', 'id': '# Admin user ID'},
    {'name': '# Admin user name', 'id': '# Admin user ID'},
    {'name': '# Admin user name', 'id': '# Admin user ID'},
  ];

  final List<Map<String, dynamic>> _operatorsRolesLeftData = [
    {
      'selected': false,
      'name': 'Super Admin',
      'type': 'Type A',
      'no': '15',
    },
    {
      'selected': false,
      'name': 'Admin Manager',
      'type': 'Type B',
      'no': '10',
    },
    {
      'selected': false,
      'name': 'Operator',
      'type': 'Type C',
      'no': '8',
    },
    {
      'selected': false,
      'name': 'Support',
      'type': 'Type D',
      'no': '12',
    },
    {
      'selected': false,
      'name': 'Guest',
      'type': 'Type E',
      'no': '5',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

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
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      "Operators",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Divider(thickness: 1),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Mymatethemes.commonbuttonclr,
                          ),
                          child: Text("Add New Users"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          child: Container(
                            width: 1,
                            height: 5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Mymatethemes.commonbuttonclr,
                      ),
                      child: Text("Delete"),
                    ),
                  ),
                  SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                          
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(4),
                            width: 280,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CupertinoSegmentedControl<int>(
                              children: {
                                0: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Operators",
                                    style: TextStyle(
                                      color: _selectedTab == 0 ? Colors.white : Colors.black,
                                      fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                1: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Operators Roles",
                                    style: TextStyle(
                                      color: _selectedTab == 1 ? Colors.white : Colors.black,
                                      fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              },
                              onValueChanged: (int newValue) {
                                setState(() {
                                  _selectedTab = newValue;
                                });
                              },
                              groupValue: _selectedTab,
                              borderColor: Mymatethemes.tabclr,
                              unselectedColor: Mymatethemes.tabclrunselected,
                              selectedColor: Mymatethemes.tabclr,
                              padding: const EdgeInsets.all(0),
                            ),
                          ),

                          Container(
                            height: 500,
                            child: _selectedTab == 0
                                ? _buildOperatorsTable()
                                : _buildOperatorsRoles(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorsTable() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          child: Row(
            children: const [
              SizedBox(width: 40),
              SizedBox(width: 50),
              Expanded(
                flex: 2,
                child: Text(
                  'NAME',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'ROLE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 70),
              SizedBox(width: 70),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _operatorsData.length,
            itemBuilder: (context, index) {
              final operator = _operatorsData[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Checkbox(
                        value: operator['selected'],
                        onChanged: (bool? newValue) {
                          setState(() {
                            _operatorsData[index]['selected'] = newValue ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Mymatethemes.promotitleColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    // Name
                    Expanded(
                      flex: 2,
                      child: Text(operator['name'] ?? ''),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(operator['id'] ?? ''),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(operator['role'] ?? ''),
                    ),
                    SizedBox(
                      width: 70,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F47DD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        child: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 70,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F47DD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        child: const Text('View'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOperatorsRoles() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                    child: Row(
                      children: const [
                        SizedBox(width: 40),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'NAME',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'TYPE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'NO',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 70),
                      ],
                    ),
                  ),
                  // Table Body
                  Expanded(
                    child: ListView.builder(
                      itemCount: _operatorsRolesLeftData.length,
                      itemBuilder: (context, index) {
                        final rowData = _operatorsRolesLeftData[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: Checkbox(
                                  value: rowData['selected'],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _operatorsRolesLeftData[index]['selected'] = newValue ?? false;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              // NAME
                              Expanded(
                                flex: 2,
                                child: Text(rowData['name'] ?? ''),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(rowData['type'] ?? ''),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(rowData['no'] ?? ''),
                              ),
                              SizedBox(
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Mymatethemes.tabclr,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    textStyle: const TextStyle(fontSize: 14,color: Colors.black38),
                                  ),
                                  child: const Text('View'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'NAME',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _operatorsRolesRightData.length,
                      itemBuilder: (context, index) {
                        final rowData = _operatorsRolesRightData[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(rowData['name'] ?? ''),
                              ),
                              Expanded(
                                child: Text(rowData['id'] ?? ''),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
