import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/intrested_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? gender;

  void _selectGender(String selectedGender) {
    setState(() {
      gender = selectedGender;
    });

    // Optional: navigate to the next screen or show a snackbar
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Selected: $gender')),
    // );

    // Example: Navigate to next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IntrestedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
 mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StepProgressBar(
                  currentStep: 4, // <-- first page
                  totalSteps: 20, // <-- adjust based on your flow
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "What's your gender?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildGenderButton("Woman"),
              const SizedBox(height: 20),
              _buildGenderButton("Man"),
              const SizedBox(height: 20),
              _buildGenderButton("Other"),
              const SizedBox(height: 30),
              if (gender != null)
                Text(
                  "Selected: $gender",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: () => _selectGender(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          // foregroundColor: Colors.black,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
