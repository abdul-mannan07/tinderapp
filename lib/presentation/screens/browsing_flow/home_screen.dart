import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/home_arrow_screen.dart';
import 'package:tinderapp/presentation/screens/provider/home_provider.dart';
import 'package:tinderapp/presentation/screens/models/model_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.profileFlagSetup();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

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
          title: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => homeProvider.toggleScreen(true),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 2,
                        color: homeProvider.isForYouScreen
                            ? Colors.black
                            : Colors.grey,
                      ),
                      backgroundColor: homeProvider.isForYouScreen
                          ? Colors.pink.shade50
                          : Colors.white,
                    ),
                    child: Text(
                      "For You",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(width: 3),

                  ElevatedButton(
                    onPressed: () => homeProvider.toggleScreen(false),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 2,
                        color: homeProvider.isForYouScreen
                            ? Colors.grey
                            : Colors.black,
                      ),
                      backgroundColor: homeProvider.isForYouScreen
                          ? Colors.white
                          : Colors.pink.shade50,
                    ),
                    child: Text(
                      "Double Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
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
        body: homeProvider.isForYouScreen
            ? Stack(
                children: [
                  // 🟢 PageView for profile images, name, and description
                  Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) {
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          homeProvider.setCurrentProfileIndex(index);
                          homeProvider.resetProfilePicIndex(index);
                          //homeProvider.currentProfileIndex = index;
                          // currentIndexes[index] = 0; // reset photo to first
                        },
                        itemCount: homeProvider.profile.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final profile =
                              homeProvider.profile[index]; // Profile object
                          final pics = profile.pics;
                          final name = profile.name;
                          final desc = profile.descp;
                          final picIndex = homeProvider.currentIndexes[index];

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
                                  onTap: () => homeProvider.showPics(index),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.74,
                                      width: double.infinity,
                                      child: Image.asset(
                                        pics[homeProvider
                                            .currentIndexes[index]],
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color:
                                                    picIndex ==
                                                        homeProvider
                                                            .currentIndexes[index]
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                final currentIndex =
                                                    homeProvider
                                                        .currentProfileIndex;
                                                final currentFlags = homeProvider
                                                    .profileFlags[currentIndex];

                                                // Only pass the three flags needed for HomeArrowScreen
                                                final filteredFlags = {
                                                  'star':
                                                      currentFlags['star'] ??
                                                      false,
                                                  'fav':
                                                      currentFlags['fav'] ??
                                                      false,
                                                  'close':
                                                      currentFlags['close'] ??
                                                      false,
                                                };

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => HomeArrowScreen(
                                                      pics: homeProvider
                                                          .profile[currentIndex]
                                                          .pics,
                                                      currentIndexNow: homeProvider
                                                          .currentIndexes[currentIndex],
                                                      name: homeProvider
                                                          .profile[currentIndex]
                                                          .name,
                                                      profileIndex:
                                                          currentIndex,
                                                      filteredFlags:
                                                          Map<
                                                            String,
                                                            bool
                                                          >.from(
                                                            filteredFlags,
                                                          ), // Pass a copy
                                                    ),
                                                  ),
                                                ).then((updatedFlags) {
                                                  // 🔹 When coming back, update provider with new flags
                                                  if (updatedFlags != null &&
                                                      updatedFlags
                                                          is Map<
                                                            String,
                                                            bool
                                                          >) {
                                                    final newFlags = homeProvider
                                                        .profileFlags[currentIndex];
                                                    newFlags['star'] =
                                                        updatedFlags['star'] ??
                                                        false;
                                                    newFlags['fav'] =
                                                        updatedFlags['fav'] ??
                                                        false;
                                                    newFlags['close'] =
                                                        updatedFlags['close'] ??
                                                        false;
                                                    homeProvider.saveFlags();
                                                    homeProvider
                                                        .notifyListeners();
                                                  }
                                                });
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
                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return IconButton(
                              onPressed: () {
                                homeProvider.iconTap(
                                  'refresh',
                                  homeProvider.currentProfileIndex,
                                );
                                homeProvider.refreshDeck();
                              },
                              icon:
                                  homeProvider.profileFlags[homeProvider
                                      .currentProfileIndex]['refresh']!
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
                            );
                          },
                        ),

                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return IconButton(
                              onPressed: () {
                                final currentIndex =
                                    homeProvider.currentProfileIndex;
                                final nextIndex = currentIndex + 1;

                                if (nextIndex < homeProvider.profile.length) {
                                  // Only set close flag if there's a next profile
                                  homeProvider.iconTap('close', currentIndex);

                                  // Move to next profile
                                  _pageController.animateToPage(
                                    nextIndex,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                  homeProvider.setCurrentProfileIndex(
                                    nextIndex,
                                  );
                                } else {
                                  // Last profile: don't set close flag, just show snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("No more profiles!"),
                                    ),
                                  );
                                }
                              },
                              icon:
                                  homeProvider.profileFlags[homeProvider
                                      .currentProfileIndex]['close']!
                                  ? const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.close_outlined,
                                        size: 30,
                                        color: Colors.pink,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.close, size: 30),
                                    ),
                            );
                          },
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return IconButton(
                              onPressed: () => homeProvider.iconTap(
                                'star',
                                homeProvider.currentProfileIndex,
                              ),
                              icon:
                                  homeProvider.profileFlags[homeProvider
                                      .currentProfileIndex]['star']!
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
                            );
                          },
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return IconButton(
                              onPressed: () => homeProvider.iconTap(
                                'fav',
                                homeProvider.currentProfileIndex,
                              ),
                              icon:
                                  homeProvider.profileFlags[homeProvider
                                      .currentProfileIndex]['fav']!
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
                            );
                          },
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return IconButton(
                              onPressed: () => homeProvider.iconTap(
                                'sent',
                                homeProvider.currentProfileIndex,
                              ),
                              icon:
                                  homeProvider.profileFlags[homeProvider
                                      .currentProfileIndex]['sent']!
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
                            );
                          },
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
