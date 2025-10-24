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
            Center(child: Text('Settings Content')),
          ],
        ),
      ),
    );
  }
}
