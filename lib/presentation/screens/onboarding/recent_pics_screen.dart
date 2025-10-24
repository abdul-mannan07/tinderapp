import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';

class RecentPicsScreen extends StatefulWidget {
  const RecentPicsScreen({super.key});

  @override
  State<RecentPicsScreen> createState() => _RecentPicsScreenState();
}

class _RecentPicsScreenState extends State<RecentPicsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text("Add your recent pics", style: AppTheme.head1),
              ),
              SizedBox(height: 50),
              Expanded(
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7, // Adjust for a taller box shape
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Stack(
                          children: [
                            DottedBorder(
                              radius: const Radius.circular(12),

                              borderType: BorderType.RRect,
                              dashPattern: const [6, 3], // 6px dash, 3px gap
                              color: Colors.white,
                              strokeWidth: 1.5,
                              child: ClipRRect(
                                child: SizedBox(
                                  // height: 160,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  // child: Container(color: Colors.amber),
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFE3C72,
                                    ), // Red/Pink color
                                    shape: BoxShape.circle,
                                    // White border around the circle
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: DottedBorder(
                    //     radius: const Radius.circular(12),

                    //     borderType: BorderType.RRect,
                    //     dashPattern: const [6, 3], // 6px dash, 3px gap
                    //     color: Colors.white,
                    //     strokeWidth: 1.5,
                    //     child: ClipRRect(
                    //       child: Container(
                    //         child: Stack(
                    //           children: [
                    //             Positioned.fill(
                    //               child: Image.asset(
                    //                 "assets/image/google.png",
                    //                 fit: BoxFit.fill,
                    //               ),
                    //             ),
                    //             Positioned(
                    //               bottom: -15,
                    //               right: -15,
                    //               child: GestureDetector(
                    //                 onTap: () {},
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     color: const Color(
                    //                       0xFFFE3C72,
                    //                     ), // Red/Pink color
                    //                     shape: BoxShape.circle,
                    //                     // White border around the circle
                    //                     border: Border.all(
                    //                       color: Colors.white,
                    //                       width: 3.0,
                    //                     ),
                    //                   ),
                    //                   padding: const EdgeInsets.all(4.0),
                    //                   child: const Icon(
                    //                     Icons.add,
                    //                     color: Colors.white,
                    //                     size: 16.0,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),

              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.amber),
                title: Text(
                  "Hey! Let's add 2 to start. we\nrecommend a face pic.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                        builder: (context) => BottomNavScreen(),
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
