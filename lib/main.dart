import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/splash_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
// import 'package:tinderapp/presentation/screens/provider/home_arrow_provider.dart';
// import 'package:tinderapp/presentation/screens/provider/home_provider.dart';
// import 'presentation/screens/provider/image_slider_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tinderapp/provider/home_arrow_provider.dart';
import 'package:tinderapp/provider/home_provider.dart';
import 'package:tinderapp/provider/image_slider_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageSliderProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HomeArrowProvider()),
      ],
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
      home: SplashScreen(),
      // home: PhoneScreen(),
      // home: NameScreen(),
      // home: LookingforScreen(),
      // home: DobScreen(),
      //home: BottomNavScreen(),
      // home: RecentPicsScreen(),
      // home: LikesScreen(),
    );
  }
}
