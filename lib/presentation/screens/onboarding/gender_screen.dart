import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/onboarding/intrested_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  // String? gender;

  // void _selectGender(String selectedGender) {
  //   setState(() {
  //     gender = selectedGender;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StepProgressBar(
                  currentStep: 6, totalSteps: 20
                  ),
              ),
              SizedBox(
                width: screenWidth * 0.8,
                child: const Text(
                  "What's your gender?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<NameProvider>(
                  builder: (context, provider, child) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () =>
                                provider.selectGender(provider.genders[index]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  provider.gender == provider.genders[index]
                                  ? Colors.pink
                                  : Colors.white,
                              foregroundColor:
                                  provider.gender == provider.genders[index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: Text(
                              provider.genders[index],
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                      ),
                      itemCount: provider.genders.length,
                    );
                  },
                ),
              ),
              // const SizedBox(height: 20),
              // _buildGenderButton("Woman"),
              // const SizedBox(height: 20),
              // _buildGenderButton("Man"),
              // const SizedBox(height: 20),
              // _buildGenderButton("Other"),
              // const SizedBox(height: 30),
              // if (gender != null)
              //   Text(
              //     "Selected: $gender",
              //     style: const TextStyle(color: Colors.white, fontSize: 18),
              //   ),
              const Spacer(),
              Consumer<NameProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.gender == null
                            ? Colors.grey
                            : Colors.pink,
                      ),
                      onPressed: provider.gender == null
                          ? null
                          : () {
                              print(provider.gender);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const IntrestedScreen(),
                                ),
                              );
                            },
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

//   Widget _buildGenderButton(String label) {
//     final isSelected = gender == label;
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.8,
//       height: MediaQuery.of(context).size.height * 0.06,
//       child: ElevatedButton(
//         onPressed: () => _selectGender(label),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected ? Colors.pink : Colors.white,
//           foregroundColor: isSelected ? Colors.white : Colors.black,
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
