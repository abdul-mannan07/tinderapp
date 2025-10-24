import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/account_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/likes_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/home_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/inbox_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/search_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;
  void currentTap(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List currentScreen = [
    HomeScreen(),
    SearchScreen(),
    LikesScreen(),
    InboxScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   // centerTitle: true,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Icon(Icons.local_fire_department, color: Colors.pink, size: 30),
        //       Text(
        //         "tinder",
        //         style: TextStyle(
        //           color: Colors.pink,
        //           fontSize: 25,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: currentTap,
          type: BottomNavigationBarType.shifting,
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30),
          //selectedItemColor: Colors.pink,
          selectedIconTheme: IconThemeData(color: Colors.pink, size: 40),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Search",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "first"),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: "first",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "first",
            ),
          ],
        ),
        body: currentScreen[selectedIndex],
      ),
    );
  }
}
