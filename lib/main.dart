import 'package:dashboard_my_mate/Homepages/home_screen.dart';
import 'package:dashboard_my_mate/Homepages/promos_offers_page.dart';
import 'package:dashboard_my_mate/Test.dart';
import 'package:dashboard_my_mate/client.dart';
import 'package:dashboard_my_mate/dbconnection/clients.dart';
import 'package:dashboard_my_mate/firebase_options.dart';
import 'package:dashboard_my_mate/user_chart/User_chart.dart';
import 'package:dashboard_my_mate/widgets/multiplepichart.dart';
import 'package:dashboard_my_mate/widgets/package_boost.dart';
import 'package:dashboard_my_mate/widgets/subscriberschart.dart';
import 'package:dashboard_my_mate/users_details/about_me.dart';
import 'package:dashboard_my_mate/widgets/userstatics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Homepages/UserbasedPromodetailpage.dart';
import 'Homepages/timebasedPromoDetailPage.dart';
import 'Homepages/manage_user.dart';
import 'Homepages/tokens_screen.dart';
import 'Homepages/unlimitedUserbasedPromodetails.dart';
import 'Homepages/unlimitedtimebasedPromodetails.dart';
import 'Homepages/user_screen.dart';
import 'widgets/api_users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  AstrologyPage(),
    );
  }
}

