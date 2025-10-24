import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/onboarding/lifestyle_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';

class LookingforScreen extends StatefulWidget {
  const LookingforScreen({super.key});

  @override
  State<LookingforScreen> createState() => _LookingforScreenState();
}

class _LookingforScreenState extends State<LookingforScreen> {
  List<String> a = [
    "Long-term partner",
    "Long-term open to short",
    "Short-term open to long",
    "Short-term fun",
    "New friends",
    "Still figuring it out",
  ];
  List images = [
    "assets/images/pink_heart.png",
    "assets/images/heart_face.png",
    "assets/images/glasses.png",
    "assets/images/celebration.png",
    "assets/images/waving.png",
    "assets/images/thinking.png",
  ];
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Right now I'm\nlooking for...\n",
                  style: AppTheme.head1,
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
              Expanded(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 150,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("object");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                           return   LifestyleScreen();
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(images[index]),
                                ),
                                Text(
                                  a[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: a.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
