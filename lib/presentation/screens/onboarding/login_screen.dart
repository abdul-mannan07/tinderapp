import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/phone_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/login_screen_widget.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height, // Add this line
          decoration: BoxDecoration(gradient: AppTheme.tinderGradient),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 160),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 80,
                    ),
                    Text(
                      "tinder",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        // letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ), // instead of Padding with EdgeInsetsGeometry
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Text(
                    "By tapping ‘Sign in’ you agree to our Terms.\n"
                    "Learn how we process your data in our\n"
                    "Privacy Policy and Cookies Policy.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SocialLoginButton(
                    imageAssets: "assets/images/person.png",
                    text: "Create new account",
                    onTapCon: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneScreen()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SocialLoginButton(
                    imageAssets: "assets/images/google.png",
                    text: "Continue With Google",
                    onTapCon: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SocialLoginButton(
                    imageAssets: "assets/images/facebook.png",
                    text: "Continue With Facebook",
                    onTapCon: () {
                      // print("object");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SocialLoginButton(
                    imageAssets: "assets/images/phone.png",
                    text: "Continue With Phone Number",
                    onTapCon: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Trouble Signing in?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
