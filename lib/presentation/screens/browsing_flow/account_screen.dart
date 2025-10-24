import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     // centerTitle: true,
        //     title: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.local_fire_department, color: Colors.pink, size: 30),
        //         Text(
        //           "tinder",
        //           style: TextStyle(
        //             color: Colors.pink,
        //             fontSize: 25,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        body: Center(
          child: Text(
            "Account Screen",
            style: TextStyle(color: Colors.tealAccent),
          ),
        ),
      ),
    );
  }
}
