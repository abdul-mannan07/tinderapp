import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/home_arrow_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  List pics = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman1.jpg",
    "assets/search/youngwoman1.jpg",
    "assets/search/youngwoman2.jpg",
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
        drawer: Drawer(
          child: ListView(
            children: [
              Text("data"),
              Text("data"),
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scafoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.settings_sharp, size: 30),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: showBorder,
                style: buttonFlag
                    ? ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: Colors.black),
                      )
                    : ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: Colors.grey),
                      ),
                child: Text(
                  "For You",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // optional
                ),
              ),

              SizedBox(width: 3),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Double Date",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.flash_on, size: 30, color: Colors.pink),
              ),
            ),
          ],
        ),
        body: Container(
          // clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.black,
            color: Colors.grey,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.80,
          // child: Image.asset(
          //   "assets/search/clubdj.png",
          //   // fit: BoxFit.fitHeight,
          // ),
          child: Stack(
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: showPics,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.74,
                    width: double.infinity,
                    child: Image.asset(
                      pics[currentIndex],
                      fit: BoxFit.fitHeight,
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
                bottom: -5,
                left: 0,
                right: 0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Barbra Charley",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeArrowScreen(),
                                  ),
                                );
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          descp[currentIndex],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                iconTap('refresh');
                              },
                              icon: refreshFlag == true
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.refresh,
                                        size: 30,
                                        color: Colors.pink,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(Icons.refresh, size: 25),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                iconTap('close');
                              },
                              icon: closeFlag == true
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.close_outlined,
                                        size: 30,

                                        color: Colors.pink,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(Icons.close, size: 30),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                iconTap('star');
                              },
                              icon: starFlag == true
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.star,
                                        size: 30,
                                        color: Colors.pink,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(Icons.star, size: 25),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                iconTap('fav');
                              },
                              icon: favFlag == true
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: Colors.pink,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(Icons.favorite, size: 30),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                iconTap('sent');
                              },
                              icon: sentFlag == true
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.send_rounded,
                                        size: 30,
                                        color: Colors.pink,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(Icons.send_rounded, size: 25),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Positioned(
        //   //top: 20,
        //   child: Container(
        //     width: double.infinity,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.center_focus_weak_sharp),
        //         ),
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.center_focus_weak_sharp),
        //         ),
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.center_focus_weak_sharp),
        //         ),
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.center_focus_weak_sharp),
        //         ),
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.center_focus_weak_sharp),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
