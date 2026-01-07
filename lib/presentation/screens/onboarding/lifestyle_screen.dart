import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/hobbies_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
                StepProgressBar(
                currentStep: 12, totalSteps: 20,
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's talk lifestyle\nhabits, Judy\n",
                        style: AppTheme.head1,
                      ),
                      const TextSpan(
                        text: "Do their habits match yours? You go first.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                    Consumer<NameProvider>(
                      builder: (context, provider, _) => SingleChoice(
                        icon: Icons.wine_bar,
                        question: "How often do you drink?",
                        options: [
                          "Not for me",
                          "Sober",
                          "Sober curious",
                          "On special occasions",
                          "Socially on weekends",
                          "Most Nights",
                        ],
                        selected: provider.selectedDrink,
                        onSelectedOpt: provider.setDrink,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 5, color: Colors.white),
                    const SizedBox(height: 30),
                    Consumer<NameProvider>(
                      builder: (context, provider, _) => SingleChoice(
                        icon: Icons.smoking_rooms,
                        question: "How often do you smoke?",
                        options: [
                          "Social smoker",
                          "Smoker when drinking",
                          "Non-smoker",
                          "Smoker",
                          "Trying to quit",
                        ],
                        selected: provider.selectedSmoke,
                        onSelectedOpt: provider.setSmoke,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 5, color: Colors.white),
                    const SizedBox(height: 30),
                    Consumer<NameProvider>(
                      builder: (context, provider, _) => SingleChoice(
                        icon: Icons.fitness_center,
                        question: "Do you workout?",
                        options: ["Everyday", "Often", "Sometimes", "Never"],
                        selected: provider.selectedWorkout,
                        onSelectedOpt: provider.setWorkout,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 5, color: Colors.white),
                    const SizedBox(height: 30),
                    Consumer<NameProvider>(
                      builder: (context, provider, _) => SingleChoice(
                        icon: Icons.pets,
                        question: "Do you have any pet?",
                        options: ["Dog", "Cat", "Reptile", "Amphibian", "Bird"],
                        selected: provider.selectedPet,
                        onSelectedOpt: provider.setPet,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Consumer<NameProvider>(
                  builder: (context, provider, _) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.isNextEnabled
                            ? Colors.pink
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: provider.isNextEnabled
                          ? () {
                              print(provider.selectedDrink);
                              print(provider.selectedPet);
                              print(provider.selectedSmoke);
                              print(provider.selectedWorkout);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HobbiesScreen(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleChoice extends StatelessWidget {
  final IconData icon;
  final String question;
  final List<String> options;
  final String? selected;
  final Function(String) onSelectedOpt;

  const SingleChoice({
    super.key,
    required this.icon,
    required this.question,
    required this.options,
    required this.selected,
    required this.onSelectedOpt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final bool isSelected = selected == opt;
            return ChoiceChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (_) => onSelectedOpt(opt),
              selectedColor: Colors.blueGrey,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
