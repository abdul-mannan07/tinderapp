import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/signup_screen.dart';

class SplashServices {
  void checkLogin(State state) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    debugPrint('Current user: ${user?.uid ?? "No user logged in"}');

    Timer(const Duration(seconds: 3), () {
      if (!state.mounted) return; // ✅ safe check

      if (user != null) {
        Navigator.pushReplacement(
          state.context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
        );
      } else {
        Navigator.pushReplacement(
          state.context,
          MaterialPageRoute(builder: (_) => const SignUpScreen()),
        );
      }
    });
  }
}
