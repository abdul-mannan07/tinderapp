import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/gender_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/lifestyle_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/signup_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/lookingfor_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/splash_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
import 'package:tinderapp/provider/account_provider.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';
import 'provider/auth_provider.dart';
import 'provider/home_provider.dart';
import 'provider/home_arrow_provider.dart';
import 'provider/image_slider_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => AuthServicesProvider()),
        ChangeNotifierProvider(create: (_) => ImageSliderProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HomeArrowProvider()),
        ChangeNotifierProvider(create: (_) => NameProvider()), // <-- Add this
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ), // <-- Add this
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
      home: SplashScreen(),
      //home: GenderScreen(),
      //home: LookingforScreen(),
      //home: LifestyleScreen(),
    );
  }
}
