import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinderapp/presentation/screens/onboarding/name_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer();
  @override
  void dispose() {
    phoneController.dispose();
    _gestureRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StepProgressBar(
                  currentStep: 1, // <-- first page
                  totalSteps: 5, // <-- adjust based on your flow
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,

                child: Text(
                  "Can we get \n your phone number?",
                  style: AppTheme.head1,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _globalKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,

                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We'll text a code to verify you're really you. Message and data rates may apply.\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "What happens if your number changes?",
                        style: TextStyle(
                          color: Colors.blueAccent, // Typically a link color
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Colors.blue, // Optional for link feel
                        ),
                        recognizer: _gestureRecognizer
                          ..onTap = () {
                            // Handle the link tap here, e.g., navigate or show dialog
                            print("Link tapped!");
                            // Navigator.push(context, MaterialPageRoute(builder: (_) => YourNewPage()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                //decoration: BoxDecoration(color: Colors.grey),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NameScreen()),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 96, 99, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
