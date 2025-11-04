import 'package:flutter/material.dart';

class HomeArrowScreen extends StatefulWidget {
  final String name;
  final List<String> pics;
  final int currentIndexNow;
  final int profileIndex;
  final Map<String, bool> filteredFlags; // ✅ only 'star', 'fav', 'close'

  const HomeArrowScreen({
    super.key,
    required this.name,
    required this.pics,
    required this.currentIndexNow,
    required this.profileIndex,
    required this.filteredFlags,
  });

  @override
  State<HomeArrowScreen> createState() => _HomeArrowScreenState();
}

class _HomeArrowScreenState extends State<HomeArrowScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late int currentIndex;
  late bool closeFlag;
  late bool starFlag;
  late bool favFlag;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndexNow;

    // Copy initial flags
    closeFlag = widget.filteredFlags['close'] ?? false;
    starFlag = widget.filteredFlags['star'] ?? false;
    favFlag = widget.filteredFlags['fav'] ?? false;
  }

  void showPics() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.pics.length;
    });
  }

  void iconTap(String iconName) {
    setState(() {
      closeFlag = false;
      starFlag = false;
      favFlag = false;

      switch (iconName) {
        case 'close':
          closeFlag = true;
          break;
        case 'star':
          starFlag = true;
          break;
        case 'fav':
          favFlag = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 🔹 Return updated flags to HomeScreen when popping
        Navigator.pop(context, {
          'star': starFlag,
          'fav': favFlag,
          'close': closeFlag,
        });
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'star': starFlag,
                    'fav': favFlag,
                    'close': closeFlag,
                  });
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
                          GestureDetector(
                            onTap: showPics,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: double.infinity,
                                child: Image.asset(
                                  widget.pics[currentIndex],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text("Profile details here..."),
                    ],
                  ),
                ),
              ),
              // 🔹 Bottom Buttons
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
      ),
    );
  }
}
