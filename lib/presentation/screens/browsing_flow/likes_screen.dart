import 'package:flutter/material.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // 'length' is the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.local_fire_department, color: Colors.pink, size: 35),
              Text(
                "tinder",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            dividerHeight: 2,
            dividerColor: Colors.grey,
            indicatorColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.tab,
            // indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: [
              Tab(
                // icon: Icon(Icons.home),
                text: "Likes",
              ),
              Tab(
                // icon: Icon(Icons.settings),
                text: "Top Picks",
              ),
              // Tab(icon: Icon(Icons.person), text: "Profile"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upgrade to Gold to see people\nwho have already liked you.',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Icon(
                          Icons.ads_click_rounded,
                          size: 70,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "See People who liked you with\n"),
                              TextSpan(
                                text: "Tinder Gold",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {},
                    child: Text(
                      "See Who Likes You",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Upgrade to Tinder Gold for \nmore Top Picks!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Expanded gives GridView/Stack the remaining space
                Expanded(
                  child: PlaceHolderTabSec()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class PlaceHolderTabSec extends StatelessWidget {
  const PlaceHolderTabSec({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
                    children: [
                      // GridView fills the stack
                      GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/search/clubdj.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min, // Important
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "data",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "data",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.white,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.lightBlue,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[400],
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Unlock All top Picks",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
  }
}