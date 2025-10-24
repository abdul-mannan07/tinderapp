//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinderapp/presentation/screens/onboarding/dob_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
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
                  currentStep: 2, // <-- first page
                  totalSteps: 10, // <-- adjust based on your flow
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text("What's your\nfirst name?", style: AppTheme.head1),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _globalKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),

                    controller: nameController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hint: Text("Enter your name")),
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
                        text: "This is how it'll appear on your profile.\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Can't change it later.",
                        style: TextStyle(
                          color: Colors.white, // Typically a link color
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                          // decorationColor:
                          //     Colors.blue, // Optional for link feel
                        ),
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
                      MaterialPageRoute(builder: (context) => DobScreen()),
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
