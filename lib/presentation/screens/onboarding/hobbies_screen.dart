import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/recent_pics_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  String? selectedHobbies;

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
                        text: "What are you into?\n",
                        style: AppTheme.head1,
                      ),
                      TextSpan(
                        text: "You like what you like. Now, let everyone know.",
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
                      options: [
                        "German Hip Hop",
                        "Fridays for Future",
                        "Self Care",
                        "Meditation",
                        "Sushi",
                        "Basketball",
                        "Second-hand apparel",
                        "Snowboarding",
                        "Skiing",
                        "Festivals",
                        "Tattoos",
                        "Activism",
                        "Crossfit",
                        "Muay Thai",
                        "Artistic Swimming",
                        "Beach Volleyball",
                        "Flag Football",
                        "Athletics",
                        "Rhythmic Gymnastics",
                        "Karate",
                        "Softball",
                        "Diving",
                        "Trampoline",
                        "Taekwondo",
                        "Handball",
                        "Judo",
                        "Lacrosse",
                        "Water Polo",
                        "Ice Hockey",
                        "Rowing",
                        "Squash",
                        "Luge",
                        "Sports Shooting",
                        "Walking",
                        "K-Pop",
                        "Reading",
                        "Sports",
                        "Aquarium",
                        "Instagram",
                        "Hot Springs",
                        "Photography",
                        "Exhibition",
                        "Shopping",
                        "Foodie Tour",
                        "Escape Cafe",
                      ],
                      selected: selectedHobbies,
                      onSelectedOpt: (val) => setState(() {
                        selectedHobbies = val;
                      }),
                    ),
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
                      MaterialPageRoute(
                        builder: (context) => RecentPicsScreen(),
                      ),
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
  final List<String> options;
  final String? selected;
  final Function(String) onSelectedOpt;
  const SingleChoice({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelectedOpt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
