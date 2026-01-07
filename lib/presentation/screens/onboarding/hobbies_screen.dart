import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/recent_pics_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NameProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
                StepProgressBar(
                currentStep: 14, totalSteps: 20,
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: const Text(
                  "What are you into?\nYou like what you like. Now, let everyone know.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(height: 5, color: Colors.white),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    MultiChoice(
                      options: provider.allHobbies, // Use hobbies from provider
                      selectedOptions: provider.selectedHobbies,
                      onToggle: (option) => provider.toggleHobby(option),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.selectedHobbies.isNotEmpty
                        ? Colors.pink
                        : Colors.grey,
                  ),
                  onPressed: provider.selectedHobbies.isNotEmpty
                      ? () {
                          print(provider.selectedHobbies);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RecentPicsScreen(),
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
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiChoice extends StatelessWidget {
  final List<String> options;
  final Set<String> selectedOptions;
  final Function(String) onToggle;

  const MultiChoice({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedOptions.contains(option);
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onToggle(option),
          selectedColor: Colors.blueGrey,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
