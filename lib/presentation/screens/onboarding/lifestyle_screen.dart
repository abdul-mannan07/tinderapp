import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/hobbies_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  String? selectedDrink;
  String? selectedSmoke;
  String? selectedWorkout;
  String? selectedPet;

  //bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's talk lifestyle\nhabits, Judy\n",
                        style: AppTheme.head1,
                      ),
                      TextSpan(
                        text: "Do their habits match yours? you go first.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // child: Text(
                //   "Right now I'm\nlooking for...",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //     //  decorationStyle:
                //   ),
                // ),
              ),
              SizedBox(height: 30),
              Divider(height: 5, color: Colors.white),
              SizedBox(height: 30),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    SingleChoice(
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
                      selected: selectedDrink,
                      onSelectedOpt: (val) => setState(() {
                        selectedDrink = val;
                      }),
                    ),
                    SizedBox(height: 30),
                    Divider(height: 5, color: Colors.white),
                    SizedBox(height: 30),
                    SingleChoice(
                      icon: Icons.smoking_rooms,
                      question: "How often do you smoke?",
                      options: [
                        "Social smoker",
                        "Smoker when drinking",
                        "Non-smoker",
                        "Smoker",
                        "Trying to quit",
                      ],
                      selected: selectedSmoke,
                      onSelectedOpt: (val) =>
                          setState(() => selectedSmoke = val),
                    ),
                    SizedBox(height: 30),
                    Divider(height: 5, color: Colors.white),
                    SizedBox(height: 30),
                    SingleChoice(
                      icon: Icons.fitness_center,
                      question: "Do you workout?",
                      options: ["Everyday", "Often", "Sometimes", "Never"],
                      selected: selectedWorkout,
                      onSelectedOpt: (val) =>
                          setState(() => selectedWorkout = val),
                    ),
                    SizedBox(height: 30),
                    Divider(height: 5, color: Colors.white),
                    SizedBox(height: 30),
                    SingleChoice(
                      icon: Icons.pets,
                      question: "Do you have any pet?",
                      options: ["Dog", "Cat", "Reptile", "Amphibian", "Bird"],
                      selected: selectedPet,
                      onSelectedOpt: (val) => setState(() => selectedPet = val),
                    ), //  width: MediaQuery.of(context).size.width * 0.65,
                    // child: Row(
                    //   children: [
                    //     Icon(Icons.wine_bar, color: Colors.white),
                    //     // Spacer(),
                    //     Text(
                    //       "How often do you drink?",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.06,
                //decoration: BoxDecoration(color: Colors.grey),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    // print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HobbiesScreen()),
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
            SizedBox(width: 8),
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
