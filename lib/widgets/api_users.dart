import 'package:flutter/material.dart';

class ApiUsers extends StatefulWidget {
  @override
  _ApiUsersState createState() => _ApiUsersState();
}

class _ApiUsersState extends State<ApiUsers> {
  final int usersToday = 120;
  final int usersLast7Days = 600;
  final int usersLast30Days = 1500;

  /* Future<void> _fetchUserStats() async {
     try {
      final usersCollection = FirebaseFirestore.instance.collection('user_usage');
       final todayStats = await usersCollection.where('date', isEqualTo: 'today').get();
      final last7DaysStats = await usersCollection.where('date', isEqualTo: 'last7days').get();
      final last30DaysStats = await usersCollection.where('date', isEqualTo: 'last30days').get();

       setState(() {
         usersToday = todayStats.docs.length;
         usersLast7Days = last7DaysStats.docs.length;
        usersLast30Days = last30DaysStats.docs.length;
       });
     } catch (e) {
       print('Error fetching data: $e');
     }
   }

  @override
  void initState() {
    super.initState();
     _fetchUserStats();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$usersToday',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$usersLast7Days',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Past 7 days',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'API',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$usersLast30Days',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Past 30 days',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
