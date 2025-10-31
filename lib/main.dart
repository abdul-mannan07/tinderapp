import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
import 'provider/image_slider_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ImageSliderProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // You can change this line to test various flows:
      // home: SplashScreen(),
      // home: PhoneScreen(),
      // home: NameScreen(),
      // home: LookingforScreen(),
      // home: DobScreen(),
      home: BottomNavScreen(),
      // home: RecentPicsScreen(),
      // home: LikesScreen(),
    );
  }
}
