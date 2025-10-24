import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List photos = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman2.jpg",
  ];
  List bottomPhotos = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman1.jpg",
    "assets/search/clubdj.png",
    "assets/search/youngwoman2.jpg",
  ];
  List club = ["assets/search/clubdj.png"];
  List listText = ["Let's be\nfreinds", "Coffee\ndate"];
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
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.95,
                  //color: Colors.amber,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,

                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 1,

                    //   childAspectRatio:
                    //       MediaQuery.of(context).size.width /
                    //       (MediaQuery.of(context).size.height * 0.32),
                    //   //   mainAxisSpacing: 8,
                    //   //childAspectRatio: 1, // Adjust for a taller box shape
                    //   //crossAxisSpacing: 1,
                    // ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.46,

                        // height: MediaQuery.of(context).size.height * 0.4,
                        margin: EdgeInsets.only(
                          right: 8,
                        ), // spacing between items
                        // Adjust width as needed
                        clipBehavior: Clip.hardEdge,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.black,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.95,
                        child: Stack(
                          children: [
                            Image.asset(
                              photos[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  listText[index],
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.32,
                //   width: MediaQuery.of(context).size.width * 0.95,
                //   color: Colors.amber,
                //   child: GridView.builder(
                //     //  scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: photos.length,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       //   mainAxisSpacing: 8,
                //       childAspectRatio: 0.7, // Adjust for a taller box shape
                //       crossAxisSpacing: 5,
                //     ),
                //     itemBuilder: (context, index) {
                //       return Container(
                //         clipBehavior: Clip.hardEdge,

                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           // color: Colors.black,
                //         ),
                //         // height: MediaQuery.of(context).size.height * 0.95,
                //         child: Stack(
                //           children: [
                //             Image.asset(
                //               photos[index],
                //               fit: BoxFit.cover,
                //               errorBuilder: (context, error, stackTrace) {
                //                 print('Error loading image: $error');
                //                 return Icon(Icons.error, color: Colors.red);
                //               },
                //             ),
                //             // Align(
                //             //   alignment: Alignment
                //             //       .centerRight, // vertical center, horizontal right
                //             //   child: Padding(
                //             //     padding: const EdgeInsets.only(
                //             //       right: 8.0,
                //             //     ), // optional: spacing from edge
                //             //     child: Text(
                //             //       "Let's be\nfreinds", // consider fixing typo to "friends"
                //             //       textAlign: TextAlign.right,
                //             //       style: TextStyle(
                //             //         fontSize: 20,
                //             //         fontWeight: FontWeight.bold,
                //             //         color: Colors.white,
                //             //       ),
                //             //     ),
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 8),
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.95,

                  // color: Colors.amber,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,

                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 1,

                    //   childAspectRatio:
                    //       MediaQuery.of(context).size.width /
                    //       (MediaQuery.of(context).size.height * 0.32),
                    //   //   mainAxisSpacing: 8,
                    //   //childAspectRatio: 1, // Adjust for a taller box shape
                    //   //crossAxisSpacing: 1,
                    // ),
                    itemBuilder: (context, index) {
                      return Container(
                        width:
                            MediaQuery.of(context).size.width *
                            0.95, // <- This is key
                        margin: EdgeInsets.only(right: 8),
                        clipBehavior: Clip.hardEdge,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.black,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.95,
                        child: Stack(
                          children: [
                            Image.asset(
                              club[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Image.asset(
                                      height: 40,
                                      "assets/images/spotify.png",
                                      // fit: BoxFit.cover,
                                    ),

                                    SizedBox(height: 4),
                                    Text(
                                      "Music Mode",
                                      style: TextStyle(
                                        fontSize: 40,
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
                ),
                SizedBox(height: 10),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text.rich(
                      TextSpan(
                        text: "For You\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Recommendations",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: GridView.builder(
                    //  scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bottomPhotos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.9, // Adjust for a taller box shape
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.hardEdge,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.black,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.95,
                        child: Stack(
                          children: [
                            Image.asset(
                              bottomPhotos[index],
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                            // Align(
                            //   alignment: Alignment
                            //       .centerRight, // vertical center, horizontal right
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //       right: 8.0,
                            //     ), // optional: spacing from edge
                            //     child: Text(
                            //       "Let's be\nfreinds", // consider fixing typo to "friends"
                            //       textAlign: TextAlign.right,
                            //       style: TextStyle(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
