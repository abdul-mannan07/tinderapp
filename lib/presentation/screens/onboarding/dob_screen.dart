import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/gender_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class DobScreen extends StatefulWidget {
  const DobScreen({super.key});

  @override
  State<DobScreen> createState() => _DobScreenState();
}

class _DobScreenState extends State<DobScreen> {
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Consumer<NameProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StepProgressBar(currentStep: 4, totalSteps: 20),
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: const Text(
                      "Your b-day?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Form(
                      key: _globalKey,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: provider.dobController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Date of Birth",
                          suffixIcon: Icon(Icons.calendar_view_month_outlined),
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                        ),
                        onTap: () => provider.selectDate(context),
                        validator: (value) => provider.validateDate(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: const Text(
                      "Your profile shows your age, not your date of birth.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.isDateSelected
                            ? Colors.pink
                            : Colors.grey,
                      ),
                      onPressed: provider.isDateSelected
                          ? () {
                              if (_globalKey.currentState!.validate()) {
                                // provider.updateDob(provider.selectedDate!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GenderScreen(),
                                  ),
                                );
                              }
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
