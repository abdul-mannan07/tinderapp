import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/likes_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/dob_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/lookingfor_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/name_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/phone_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/recent_pics_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/splash_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // home: SplashScreen(),
      //home: PhoneScreen(),
      //home: NameScreen(),
      //home: LookingforScreen(),
      // home: DobScreen(),
      home: BottomNavScreen(),
      //home: RecentPicsScreen(),
      //  home: LikesScreen(),
    );
  }
}
