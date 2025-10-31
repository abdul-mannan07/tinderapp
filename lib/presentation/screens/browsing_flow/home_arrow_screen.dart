import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';

class HomeArrowScreen extends StatefulWidget {
  final String name;
  final List<String> pics;

  const HomeArrowScreen({super.key, required this.name, required this.pics});

  @override
  State<HomeArrowScreen> createState() => _HomeArrowScreenState();
}

class _HomeArrowScreenState extends State<HomeArrowScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  // Flags for bottom action icons
  bool refreshFlag = false;
  bool closeFlag = false;
  bool starFlag = false;
  bool favFlag = false;
  bool sentFlag = false;
  bool buttonFlag = false;

  void showPics() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.pics.length;
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
      buttonFlag = !buttonFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            widget.name, // dynamic profile name
            style: const TextStyle(
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
                  MaterialPageRoute(builder: (context) => BottomNavScreen()),
                );
              },
              icon: const CircleAvatar(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              width: double.infinity,
              height: double.infinity,
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
                                widget.pics[currentIndex], // dynamic pics
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                children: List.generate(widget.pics.length, (
                                  index,
                                ) {
                                  return Expanded(
                                    child: Container(
                                      height: 7,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
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
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
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
                    // Placeholders you want to keep
                    const Text("data"),
                    const Text(""),
                    const Text("data"),
                    const Text("data"),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => iconTap('close'),
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: Icon(
                          Icons.close,
                          size: 35,
                          color: closeFlag ? Colors.pink : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => iconTap('star'),
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: Icon(
                          Icons.star,
                          size: 35,
                          color: starFlag ? Colors.pink : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => iconTap('fav'),
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: Icon(
                          Icons.favorite,
                          size: 35,
                          color: favFlag ? Colors.pink : Colors.black,
                        ),
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
