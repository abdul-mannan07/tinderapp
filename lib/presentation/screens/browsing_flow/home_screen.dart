import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/home_arrow_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // 🔹 new state variable
  bool isForYouScreen = true; // true = show For You screen by default
  // 🔹 toggle screen between For You / Double Date
  void toggleScreen(bool showForYou) {
    setState(() {
      isForYouScreen = showForYou;
    });
  }

  List<Map<String, dynamic>> profile = [
    {
      "name": "Barbra Charley",
      "pics": [
        "assets/search/top.png",
        "assets/search/youngwoman1.jpg",
        "assets/search/youngwoman2.jpg",
        "assets/search/youngwoman1.jpg",
      ],
      "descp":
          "Positioned(bottom: 20) keeps the entire column near the bottom.",
    },
    {
      "name": "Alice Smith",
      "pics": [
        "assets/search/youngwoman2.jpg",
        "assets/search/youngwoman1.jpg",
      ],
      "descp":
          "Let me know if you'd like me to refactor your full Stack layout for clarity.",
    },
  ];
  int currentProfileIndex = 0; // currently visible profile
  List<int> currentIndexes = [];
  // 🔹 Icon flags for each profile (❤️ ⭐ ❌ etc.)
  // 🔹 Replace separate flags with one list of maps
  late List<Map<String, bool>> profileFlags;
  // 🔹 "For You" button toggle
  bool buttonFlag = false;
  @override
  void initState() {
    super.initState();
    // Initialize currentIndexes for all profiles
    currentIndexes = List.filled(profile.length, 0);
    // initialize icon flag lists (each profile starts as false)
    profileFlags = List.generate(
      profile.length,
      (_) => {
        'refresh': false,
        'close': false,
        'star': false,
        'fav': false,
        'sent': false,
      },
    );

    loadFlags();
  }

  void loadFlags() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('profileFlags');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      setState(() {
        profileFlags = jsonData
            .map<Map<String, bool>>((e) => Map<String, bool>.from(e))
            .toList();
      });
    }
  }

  // 🔹 Save flags persistently
  void saveFlags() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(profileFlags);
    await prefs.setString('profileFlags', jsonString);
  }

  void showPics(int profileIndex) {
    setState(() {
      final pics = profile[profileIndex]["pics"] as List<String>;
      if (currentIndexes[profileIndex] < pics.length - 1) {
        currentIndexes[profileIndex]++;
      } else {
        currentIndexes[profileIndex] = 0;
      }
    });
  }

  void iconTap(String iconName, int profileIndex) {
    setState(() {
      // reset all flags for this profile first
      profileFlags[profileIndex].updateAll((key, value) => false);
      profileFlags[profileIndex][iconName] = true;
    });
    saveFlags(); // Save changes
  }

  // 🔹 Toggle "For You" button border
  void showBorder() {
    setState(() {
      buttonFlag = !buttonFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.settings_sharp, size: 30),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => toggleScreen(true),
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
                onPressed: () => toggleScreen(false),
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
        body: isForYouScreen
            ? Stack(
                children: [
                  // 🟢 PageView for profile images, name, and description
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentProfileIndex = index;
                        currentIndexes[index] = 0; // reset photo to first
                      });
                    },
                    itemCount: profile.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final pics = profile[index]["pics"] as List<String>;
                      final name = profile[index]["name"];
                      final desc = profile[index]["descp"];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () => showPics(index),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.74,
                                  width: double.infinity,
                                  child: Image.asset(
                                    pics[currentIndexes[index]],
                                    fit: BoxFit.fitHeight,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            // Top progress indicators
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Row(
                                    children: List.generate(
                                      pics.length,
                                      (picIndex) => Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 7,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color:
                                                picIndex ==
                                                    currentIndexes[index]
                                                ? Colors.white
                                                : Colors.white60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Name & description
                            Positioned(
                              bottom: 100,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(
                                          name,
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
                                                builder: (context) => HomeArrowScreen(
                                                  name:
                                                      profile[currentProfileIndex]['name'],
                                                  pics: List<String>.from(
                                                    profile[currentProfileIndex]['pics'],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const CircleAvatar(
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
                                    Text(
                                      desc!,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // 🟢 Bottom fixed icons
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () =>
                              iconTap('refresh', currentProfileIndex),
                          icon: profileFlags[currentProfileIndex]['refresh']!
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.refresh,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.refresh, size: 25),
                                ),
                        ),
                        IconButton(
                          onPressed: () =>
                              iconTap('close', currentProfileIndex),
                          icon: profileFlags[currentProfileIndex]['close']!
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close_outlined,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.close, size: 30),
                                ),
                        ),
                        IconButton(
                          onPressed: () => iconTap('star', currentProfileIndex),
                          icon: profileFlags[currentProfileIndex]['star']!
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.star,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.star, size: 25),
                                ),
                        ),
                        IconButton(
                          onPressed: () => iconTap('fav', currentProfileIndex),
                          icon: profileFlags[currentProfileIndex]['fav']!
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.favorite, size: 30),
                                ),
                        ),
                        IconButton(
                          onPressed: () => iconTap('sent', currentProfileIndex),
                          icon: profileFlags[currentProfileIndex]['sent']!
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.send_rounded,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.send_rounded, size: 25),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(child: Text("data")),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:tinderapp/presentation/screens/browsing_flow/home_arrow_screen.dart';

// class Profile {
//   final String name;
//   final List<String> pics;
//   final List<String> descp;

//   Profile({required this.name, required this.pics, required this.descp});
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final PageController _pageController = PageController(viewportFraction: 0.9);

//   List<Profile> profiles = [
//     Profile(
//       name: "Barbra Charley",
//       pics: [
//         "assets/search/top.png",
//         "assets/search/youngwoman1.jpg",
//         "assets/search/youngwoman2.jpg",
//         "assets/search/youngwoman1.jpg",
//       ],
//       descp: [
//         "Positioned(bottom: 20) keeps the entire column near the bottom.",
//         "Let me know if you'd like me to refactor your full Stack layout for clarity.",
//         "Let me know if you want me to rewrite your full Stack layout using Positioned — happy to help with that.",
//         "Some text here",
//       ],
//     ),
//     Profile(
//       name: "Alice Smith",
//       pics: [
//         "assets/search/top.png",
//         "assets/search/youngwoman2.jpg",
//         "assets/search/youngwoman1.jpg",
//       ],
//       descp: [
//         "Alice description 1",
//         "Alice description 2",
//         "Alice description 3",
//       ],
//     ),
//     // Add more profiles here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: Drawer(
//           child: ListView(
//             children: const [
//               Text("data"),
//               Text("data"),
//               Text("data"),
//               Text("data"),
//               Text("data"),
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState!.openDrawer();
//             },
//             icon: const Icon(Icons.settings_sharp, size: 30),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "For You",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 3),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "Double Date",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.flash_on, size: 30, color: Colors.pink),
//               ),
//             ),
//           ],
//         ),
//         body: PageView.builder(
//           controller: _pageController,
//           itemCount: profiles.length,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             return AnimatedBuilder(
//               animation: _pageController,
//               builder: (context, child) {
//                 double value = 1.0;
//                 if (_pageController.position.haveDimensions) {
//                   value = _pageController.page! - index;
//                   value = (1 - (value.abs() * 0.1)).clamp(0.9, 1.0);
//                 }
//                 return Transform.scale(
//                   scale: value,
//                   child: ProfileCard(profile: profiles[index]),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProfileCard extends StatefulWidget {
//   final Profile profile;

//   const ProfileCard({super.key, required this.profile});

//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }

// class _ProfileCardState extends State<ProfileCard> {
//   int currentIndex = 0;
//   bool refreshFlag = false;
//   bool closeFlag = false;
//   bool starFlag = false;
//   bool favFlag = false;
//   bool sentFlag = false;
//   bool buttonFlag = false;

//   void showPics() {
//     setState(() {
//       if (currentIndex < widget.profile.pics.length - 1) {
//         currentIndex++;
//       } else {
//         currentIndex = 0;
//       }
//     });
//   }

//   void iconTap(String iconName) {
//     setState(() {
//       refreshFlag = false;
//       closeFlag = false;
//       starFlag = false;
//       favFlag = false;
//       sentFlag = false;

//       switch (iconName) {
//         case 'refresh':
//           refreshFlag = true;
//           break;
//         case 'close':
//           closeFlag = true;
//           break;
//         case 'star':
//           starFlag = true;
//           break;
//         case 'fav':
//           favFlag = true;
//           break;
//         case 'sent':
//           sentFlag = true;
//           break;
//       }
//     });
//   }

//   void showBorder() {
//     setState(() {
//       buttonFlag = !buttonFlag;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.grey[200],
//       ),
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.80,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: showPics,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.74,
//                 width: double.infinity,
//                 child: Image.asset(
//                   widget.profile.pics[currentIndex],
//                   fit: BoxFit.fitHeight,
//                   width: double.infinity,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Row(
//                   children: List.generate(widget.profile.pics.length, (index) {
//                     return Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         height: 7,
//                         margin: const EdgeInsets.symmetric(horizontal: 2),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: index == currentIndex
//                               ? Colors.white
//                               : Colors.white60,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -5,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           widget.profile.name,
//                           style: const TextStyle(
//                             fontSize: 35,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const HomeArrowScreen(),
//                               ),
//                             );
//                           },
//                           icon: const CircleAvatar(
//                             radius: 20,
//                             backgroundColor: Colors.black,
//                             child: Icon(
//                               Icons.arrow_upward_rounded,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       widget.profile.descp[currentIndex],
//                       style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             iconTap('refresh');
//                           },
//                           icon: refreshFlag
//                               ? const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(
//                                     Icons.refresh,
//                                     size: 30,
//                                     color: Colors.pink,
//                                   ),
//                                 )
//                               : const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 25,
//                                   child: Icon(Icons.refresh, size: 25),
//                                 ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             iconTap('close');
//                           },
//                           icon: closeFlag
//                               ? const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(
//                                     Icons.close_outlined,
//                                     size: 30,
//                                     color: Colors.pink,
//                                   ),
//                                 )
//                               : const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(Icons.close, size: 30),
//                                 ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             iconTap('star');
//                           },
//                           icon: starFlag
//                               ? const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(
//                                     Icons.star,
//                                     size: 30,
//                                     color: Colors.pink,
//                                   ),
//                                 )
//                               : const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 25,
//                                   child: Icon(Icons.star, size: 25),
//                                 ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             iconTap('fav');
//                           },
//                           icon: favFlag
//                               ? const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(
//                                     Icons.favorite,
//                                     size: 30,
//                                     color: Colors.pink,
//                                   ),
//                                 )
//                               : const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(Icons.favorite, size: 30),
//                                 ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             iconTap('sent');
//                           },
//                           icon: sentFlag
//                               ? const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 30,
//                                   child: Icon(
//                                     Icons.send_rounded,
//                                     size: 30,
//                                     color: Colors.pink,
//                                   ),
//                                 )
//                               : const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 25,
//                                   child: Icon(Icons.send_rounded, size: 25),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:tinderapp/presentation/screens/browsing_flow/home_arrow_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   final List<Map<String, dynamic>> profiles = [
//     {
//       "name": "Barbra Charley",
//       "pics": [
//         "assets/search/top.png",
//         "assets/search/youngwoman1.jpg",
//         "assets/search/youngwoman2.jpg",
//       ],
//       "descp": [
//         "Positioned(bottom: 20) keeps the entire column near the bottom.",
//         "Let me know if you'd like me to refactor your full Stack layout for clarity.",
//         "Some text here",
//       ],
//     },
//     {
//       "name": "Alice Johnson",
//       "pics": [
//         "assets/search/youngwoman1.jpg",
//         "assets/search/youngwoman2.jpg",
//       ],
//       "descp": [
//         "Another profile description 1",
//         "Another profile description 2",
//       ],
//     },
//     {
//       "name": "Emily Smith",
//       "pics": [
//         "assets/search/youngwoman2.jpg",
//         "assets/search/youngwoman1.jpg",
//       ],
//       "descp": ["Emily description 1", "Emily description 2"],
//     },
//   ];

//   late List<int> currentImageIndex;
//   int currentProfileIndex = 0;
//   Offset cardOffset = Offset.zero;
//   double rotation = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     currentImageIndex = List.generate(profiles.length, (_) => 0);
//   }

//   void showNextPic(int profileIndex) {
//     setState(() {
//       final pics = profiles[profileIndex]['pics'] as List<String>;
//       if (currentImageIndex[profileIndex] < pics.length - 1) {
//         currentImageIndex[profileIndex]++;
//       } else {
//         currentImageIndex[profileIndex] = 0;
//       }
//     });
//   }

//   void onPanUpdate(DragUpdateDetails details) {
//     setState(() {
//       cardOffset += details.delta;
//       rotation = cardOffset.dx / 300; // rotation while dragging
//     });
//   }

//   void onPanEnd(DragEndDetails details) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     if (cardOffset.dx > screenWidth * 0.3) {
//       swipeCard(true);
//     } else if (cardOffset.dx < -screenWidth * 0.3) {
//       swipeCard(false);
//     } else {
//       setState(() {
//         cardOffset = Offset.zero;
//         rotation = 0.0;
//       });
//     }
//   }

//   void swipeCard(bool liked) {
//     setState(() {
//       cardOffset = Offset.zero;
//       rotation = 0.0;
//       if (currentProfileIndex < profiles.length - 1) {
//         currentProfileIndex++;
//       } else {
//         currentProfileIndex = 0; // or show “No more profiles”
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (currentProfileIndex >= profiles.length) {
//       return Scaffold(
//         body: Center(
//           child: Text("No more profiles", style: TextStyle(fontSize: 24)),
//         ),
//       );
//     }

//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: Drawer(
//           child: ListView(
//             children: const [
//               Text("data"),
//               Text("data"),
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState!.openDrawer();
//             },
//             icon: const Icon(Icons.settings_sharp, size: 30),
//           ),
//           title: const Text("Tinder Swipe Example"),
//         ),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             for (int i = currentProfileIndex + 1; i < profiles.length; i++)
//               Positioned(
//                 top: 20.0 * (i - currentProfileIndex),
//                 child: buildCard(profiles[i], currentImageIndex[i], scale: 0.95),
//               ),
//             Transform.translate(
//               offset: cardOffset,
//               child: Transform.rotate(
//                 angle: rotation,
//                 child: GestureDetector(
//                   onPanUpdate: onPanUpdate,
//                   onPanEnd: onPanEnd,
//                   onTap: () => showNextPic(currentProfileIndex),
//                   child: buildCard(
//                       profiles[currentProfileIndex],
//                       currentImageIndex[currentProfileIndex],
//                       scale: 1.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCard(Map<String, dynamic> profile, int imageIndex,
//       {double scale = 1.0}) {
//     final pics = profile['pics'] as List<String>;
//     final descp = profile['descp'] as List<String>;

//     return Container(
//       width: 350 * scale,
//       height: 500 * scale,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.grey[300],
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           )
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Image.asset(
//                 pics[imageIndex],
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.transparent, Colors.black54],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(profile['name'],
//                       style: const TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                   const SizedBox(height: 5),
//                   Text(
//                     descp[imageIndex],
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 10,
//               left: 10,
//               right: 10,
//               child: Row(
//                 children: List.generate(
//                   pics.length,
//                   (index) => Expanded(
//                     child: Container(
//                       height: 5,
//                       margin: const EdgeInsets.symmetric(horizontal: 2),
//                       decoration: BoxDecoration(
//                         color: index == imageIndex
//                             ? Colors.white
//                             : Colors.white60,
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
