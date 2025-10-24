import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/conversation_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  TextEditingController searchText = TextEditingController();
  List onlineStatus = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman1.jpg",
    "assets/search/clubdj.png",
    "assets/search/youngwoman2.jpg",
  ];
  List chatImages = [
    "assets/search/top.png",
    //"assets/images/google.png",
    "assets/search/youngwoman1.jpg",
    "assets/search/clubdj.png",
    "assets/search/youngwoman2.jpg",
  ];
  List<String> friendsName = ['Barbra', 'Ariya', 'Stark', 'Shelby', 'Zeinth'];
  List<String> sheetTitle = [
    'REPORT',
    'UPDATE SAFETY SETTINGS',
    'ACCESS SAFETY CENTER',
  ];
  List<String> sheetSubTitle = [
    'Report someone you\'re no longer matched with, or EU illegal content.',
    'Turn on features designed to help you feel safer throughout your Tinder experience.',
    'Your well-being matters. Find safety resources and tools here.',
  ];
  List icons = [
    Icon(Icons.flag, color: Colors.red, size: 30),
    Icon(Icons.settings, color: Colors.grey, size: 30),
    Icon(Icons.security, color: Colors.blueAccent, size: 30),
  ];
  List names = [
    "Emma",
    "Olivia",
    "Ava",
    "Sophia",
    "Isabella",
    "Mia",
    "Charlotte",
    "Amelia",
    "Harper",
    "Evelyn",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department, color: Colors.pink, size: 30),
              Text(
                "tinder",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.groups_3,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,

                        context: context,
                        builder: (contex) {
                          return Container(
                            height:
                                MediaQuery.of(context).size.height *
                                0.45, // optional height

                            child: Column(
                              children: [
                                SizedBox(height: 10),

                                Text(
                                  'Safety Toolkit',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: sheetTitle.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: ListTile(
                                        leading: icons[index],
                                        title: Text(
                                          sheetTitle[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          sheetSubTitle[index],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.security_rounded,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: searchText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Search 1 Matches",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "New Matches",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 230,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: onlineStatus.length,
                  //  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              onlineStatus[index],
                              height: 200,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          friendsName[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Messages",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversationScreen(
                            userName: names[index],
                            bgImg: chatImages[index],
                          ),
                        ),
                      );
                      print("object");
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        // radius: 50,
                        // backgroundColor: Colors.amberAccent,
                        maxRadius: 25,
                        minRadius: 20,
                        backgroundImage: AssetImage(chatImages[index]),
                      ),

                      title: Text(
                        names[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        "Positioned(bottom: 20) keeps the entire column near the bottom.",
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
