import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/classes/browsing_classes.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/setting_screen.dart';

class ShowMeScreen extends StatefulWidget {
  const ShowMeScreen({super.key});

  @override
  State<ShowMeScreen> createState() => _ShowMeScreenState();
}

class _ShowMeScreenState extends State<ShowMeScreen> {
  bool isSelected = false;
  int? selectedIndex;

  List<String> selectedOptions = ["Man ", "Woman", "Other"];
  //bool isWomanSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 4, title: const Text('Show Me')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Show Me ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 173,
            decoration: BrowsingClasses().myBoxDecoration,
            child: Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SettingScreen(selectedText:  selectedOptions[index],),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedOptions[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: isSelected
                                ? Colors.pink
                                : Colors.transparent,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: selectedOptions.length,
              ),
            ),
          ),
          BrowsingClasses().textAlign("Tinder Welcomes Everyone"),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("Tinder Welcomes Everyone"),
          // ),
          SizedBox(height: 20),
          BrowsingClasses().textAlign(
            "Discovery settings now show users who include more informatio about their gender indentity. Once users add information about their gender, they can select to be shown in searches which best reflects their identity.",
          ),

          // Text(
          //   "Discovery settings now show users who include more informatio about their gender indentity. Once users add information about their gender, they can select to be shown in searches which best reflects their identity.",
          // ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Learn More ',
                  style: TextStyle(
                    color: Colors.pink,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: 'about tinder\'s inclusivity feature.',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
