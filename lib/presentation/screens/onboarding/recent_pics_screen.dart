import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class RecentPicsScreen extends StatefulWidget {
  const RecentPicsScreen({super.key});

  @override
  State<RecentPicsScreen> createState() => _RecentPicsScreenState();
}

class _RecentPicsScreenState extends State<RecentPicsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              StepProgressBar(currentStep: 16, totalSteps: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text("Add your recent pics", style: AppTheme.head1),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Consumer<NameProvider>(
                  builder: (context, provider, child) {
                  //  provider.isSignUp = true; // set once for the screen
                    return GridView.builder(
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        File? imageFile = index < provider.profileImages.length
                            ? provider.profileImages[index]
                            : null;

                        return Stack(
                          children: [
                            DottedBorder(
                              radius: const Radius.circular(12),
                              borderType: BorderType.RRect,
                              dashPattern: const [6, 3],
                              color: Colors.white,
                              strokeWidth: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: imageFile != null
                                      ? Image.file(imageFile, fit: BoxFit.cover)
                                      : Image.asset(
                                          "assets/images/google.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () => provider.pickImage(context, index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFE3C72),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.amber),
                title: const Text(
                  "Hey! Let's add 2 to start. we\nrecommend a face pic.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Consumer<NameProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.canProceed
                            ? Colors.pink
                            : Colors.grey,
                      ),
                      onPressed: provider.canProceed
                          ? () {
                              provider.signUp();
                              provider.clearControllers();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavScreen(),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
