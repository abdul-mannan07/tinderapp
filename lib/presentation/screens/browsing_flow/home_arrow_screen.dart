import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/home_screen.dart';

class HomeArrowScreen extends StatefulWidget {
  const HomeArrowScreen({super.key});
  @override
  State<HomeArrowScreen> createState() => _HomeArrowScreenState();
}

class _HomeArrowScreenState extends State<HomeArrowScreen> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  List pics = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman1.jpg",
    "assets/search/youngwoman2.jpg",
    "assets/search/youngwoman1.jpg",
  ];
  List descp = [
    "Positioned(bottom: 20) keeps the entire column near the bottom.",
    "Let me know if you'd like me to refactor your full Stack layout for clarity.",
    "Let me know if you want me to rewrite your full Stack layout using Positioned — happy to help with that.",
    "Some text here",
    "Another description",
  ];
  int currentIndex = 0;
  bool refreshFlag = false;
  bool closeFlag = false;
  bool starFlag = false;
  bool favFlag = false;
  bool sentFlag = false;
  bool buttonFlag = false;

  void showPics() {
    setState(() {
      if (currentIndex < pics.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    });
  }

  void iconTap(String iconName) {
    setState(() {
      refreshFlag = false;
      closeFlag = false;
      starFlag = false;
      favFlag = false;
      sentFlag = false;

      switch (iconName) {
        case 'refresh':
          refreshFlag = true;
          break;
        case 'close':
          closeFlag = true;
          break;
        case 'star':
          starFlag = true;
          break;
        case 'fav':
          favFlag = true;
          break;
        case 'sent':
          sentFlag = true;
          break;
      }
    });
  }

  void showBorder() {
    setState(() {
      if (buttonFlag == false) {
        buttonFlag = true;
      } else {
        buttonFlag = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          title: Text(
            "Barbra Charley",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BottomNavScreen(), // or the screen you want
                  ),
                );
              },
              icon: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.arrow_downward_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        body: Stack(
          children: [
            Container(
              // clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.black,
                color: Colors.grey,
              ),
              width: double.infinity,
              height: double.infinity,
              // child: Image.asset(
              //   "assets/search/clubdj.png",
              //   // fit: BoxFit.fitHeight,
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: showPics,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,

                              width: double.infinity,
                              child: Image.asset(
                                pics[currentIndex],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   clipBehavior: Clip.hardEdge,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     // color: Colors.black,
                        //     //color: Colors.black,
                        //   ),

                        //   width: double.infinity,

                        // ),
                        //SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                children: List.generate(pics.length, (index) {
                                  return Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 7,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ), // spacing between parts
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: index == currentIndex
                                            ? Colors.white
                                            : Colors.white60,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // child: Container(
                            //   width: double.infinity,
                            //   height: 50,
                            //   child: Text("data", style: TextStyle(color: Colors.amber)),
                            //   // clipBehavior: Clip.hardEdge,
                            //   // decoration: BoxDecoration(
                            //   //   borderRadius: BorderRadius.only(
                            //   //     topLeft: Radius.circular(20),
                            //   //   ),
                            //   //   // color: Colors.black,
                            //   //   color: Colors.green,
                            //   // ),
                            // ),
                          ),
                        ),

                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: 150, // or whatever size you want
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.reply),
                                  SizedBox(width: 5),
                                  Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("data"),
                    Text(""),
                    Text("data"),
                    Text("data"),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.black,
                  // color: Colors.blueAccent,
                ),
                width: double.infinity,
                //height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        iconTap('close');
                      },
                      icon: closeFlag == true
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Icon(
                                Icons.close_outlined,
                                size: 35,

                                color: Colors.pink,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Icon(Icons.close, size: 35),
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        iconTap('star');
                      },
                      icon: starFlag == true
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Icon(
                                Icons.star,
                                size: 35,
                                color: Colors.pink,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(Icons.star, size: 30),
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        iconTap('fav');
                      },
                      icon: favFlag == true
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Icon(
                                Icons.favorite,
                                size: 35,
                                color: Colors.pink,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Icon(Icons.favorite, size: 35),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
