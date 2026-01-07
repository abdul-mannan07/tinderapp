import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/dob_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NameProvider>(context, listen: false);
      provider.enableSignUpMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvokedWithResult: (willPop, result) {
        final provider = Provider.of<NameProvider>(context, listen: false);
        provider.clearControllers();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepProgressBar(currentStep: 2, totalSteps: 20),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: const Text(
                      "What's your\nfirst name?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Form(
                    key: _globalKey,
                    child: Consumer<NameProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            // Name Field
                            TextFormField(
                              controller: provider.nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Enter your name",
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink),
                                ),
                              ),
                              validator: (value) => provider.validateName(),
                            ),
                            const SizedBox(height: 20),

                            // Email Field
                            TextFormField(
                              controller: provider.emailController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink),
                                ),
                              ),
                              validator: (value) => provider.validateEmail(),
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: provider.passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: provider.obscurePassword,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => provider.toggleObscure(),
                                ),
                              ),
                              validator: (value) => provider.validatePassword(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Text(
                      "This is how it'll appear on your profile. Can't change it later.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Next Button
                  Consumer<NameProvider>(
                    builder: (context, provider, child) {
                      return SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.isFormValid
                                ? Colors.pink
                                : Colors.grey,
                          ),
                          onPressed: provider.isFormValid
                              ? () {
                                 
                                  provider.setBasicInfo();
                                 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const DobScreen(),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
