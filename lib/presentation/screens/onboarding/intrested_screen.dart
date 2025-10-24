import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/lookingfor_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class IntrestedScreen extends StatefulWidget {
  const IntrestedScreen({super.key});

  @override
  State<IntrestedScreen> createState() => _IntrestedScreenState();
}

class _IntrestedScreenState extends State<IntrestedScreen> {
  String? insGender;

  void _selectGender(String selectedGender) {
    setState(() {
      insGender = selectedGender;
    });

    // Optional: navigate to the next screen or show a snackbar
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Selected: $gender')),
    // );

    // Example: Navigate to next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LookingforScreen()),
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
                  currentStep: 5, // <-- first page
                  totalSteps: 25, // <-- adjust based on your flow
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "Who are you \ninterested in seeing?",
                  style: AppTheme.head1,
                ),
              ),
              const SizedBox(height: 20),
              _buildInstGenderButton("Woman"),
              const SizedBox(height: 20),
              _buildInstGenderButton("Man"),
              const SizedBox(height: 20),
              _buildInstGenderButton("Everyone"),
              const SizedBox(height: 30),
              if (insGender != null)
                Text(
                  "Selected: $insGender",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstGenderButton(String label) {
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
