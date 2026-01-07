import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/lifestyle_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class LookingforScreen extends StatefulWidget {
  const LookingforScreen({super.key});

  @override
  State<LookingforScreen> createState() => _LookingforScreenState();
}

class _LookingforScreenState extends State<LookingforScreen> {
  // final List<String> options = [
  //   "Long-term partner",
  //   "Long-term open to short",
  //   "Short-term open to long",
  //   "Short-term fun",
  //   "New friends",
  //   "Still figuring it out",
  // ];

  // final List<String> images = [
  //   "assets/images/pink_heart.png",
  //   "assets/images/heart_face.png",
  //   "assets/images/glasses.png",
  //   "assets/images/celebration.png",
  //   "assets/images/waving.png",
  //   "assets/images/thinking.png",
  // ];

  // String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               StepProgressBar(
                currentStep: 10, totalSteps: 20,
                ),
              // Title
              SizedBox(
                width: double.infinity,
                child: Text.rich(
                  const TextSpan(
                    children: [
                      TextSpan(
                        text: "Right now I'm\nlooking for...\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Increase compatibility by sharing yours!",
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

              // Grid of options
              Expanded(
                child: Consumer<NameProvider>(
                  builder: (context, provider, child) {
                    return GridView.builder(
                      itemCount: provider.options.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 150,
                            crossAxisSpacing: 8,
                          ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              provider.selectOption(provider.options[index]),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color:
                                  provider.selectedOption ==
                                      provider.options[index]
                                  ? Colors.pinkAccent
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      provider.selectedOption ==
                                          provider.options[index]
                                      ? Colors.pinkAccent.withOpacity(0.5)
                                      : Colors.black54,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border:
                                  provider.selectedOption ==
                                      provider.options[index]
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  provider.images[index],
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    provider.options[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          provider.selectedOption ==
                                              provider.options[index]
                                          ? Colors.white
                                          : Colors.grey[300],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Consumer<NameProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.selectedOption != null
                            ? Colors.pink
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: provider.selectedOption != null
                          ? () {
                              print(provider.selectedOption);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LifestyleScreen(),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
