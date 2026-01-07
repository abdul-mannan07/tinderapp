import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/editprofile_screen.dart';
import 'package:tinderapp/provider/account_provider.dart';
import 'package:tinderapp/provider/image_slider_provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/setting_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? profileName;
  List<Widget> icons = [
    Icon(Icons.star, color: Colors.blueAccent),
    Icon(Icons.flash_on, color: Colors.purple),
    Icon(Icons.local_fire_department, color: Colors.pink),
  ];

  List<String> accText = ["Super Likes", "My Boosts", "Subscription"];

  @override
  void initState() {
    super.initState();

    // Start the image slider after the widget tree is built
    Future.microtask(() {
      // Start the auto-slide
      Provider.of<ImageSliderProvider>(context, listen: false).startAutoSlide();

      // Load account data
      Provider.of<AccountProvider>(context, listen: false).loadAccountData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          titleSpacing: 5,
          title: Row(
            mainAxisSize: MainAxisSize.min,
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
                      Icons.security,
                      color: Colors.grey.shade600,
                      size: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SettingScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey.shade600,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 40),
            Consumer<AccountProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                final currentUser = provider.user;
                final profileName = currentUser?.name ?? "User";

                return PlaceHolderProfile(
                  titleWidget: titleRow(profileName),
                  imgIconWidget: circleAvatarWidget("assets/search/club.png"),
                  subTitleWidget: subTitleWidget(context),
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: PlaceHolderProfile(
                titleWidget: Text(
                  "Try Double Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                imgIconWidget: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 35,
                  child: Icon(Icons.group),
                ),
                subTitleWidget: Text(
                  "Invite your friends and find other pairs.",
                ),
                trailingWidget: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icons[index],
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "0",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 10,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " ${accText[index]}\n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Get more",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 10,
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
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // SizedBox(height: 20),
            // ===== Image Slider =====
            Consumer<ImageSliderProvider>(
              builder: (context, provider, child) {
                final images = provider.imagesAddress;
                final currentIndex = provider.currentIndex;

                return Column(
                  children: [
                    GestureDetector(
                      onHorizontalDragStart: (_) => provider.stopAutoSlide(),
                      onHorizontalDragEnd: (details) {
                        provider.startAutoSlide();
                        if (details.primaryVelocity! < 0) {
                          provider.nextImage();
                        } else if (details.primaryVelocity! > 0) {
                          provider.previousImage();
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 800),
                          transitionBuilder: (child, animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset(0, 0),
                            ).animate(animation);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            key: ValueKey<String>(images[currentIndex]),
                            height: 300,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Image.asset(
                              images[currentIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        bool isActive = index == currentIndex;
                        return GestureDetector(
                          onTap: () => provider.goToIndex(index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: isActive ? 12 : 8,
                            height: isActive ? 12 : 8,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive ? Colors.pink : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Helper Widgets =====
class PlaceHolderProfile extends StatelessWidget {
  final String? img;
  final Widget imgIconWidget;
  final Widget? trailingWidget;
  final Widget? titleWidget;
  final Widget? subTitleWidget;

  const PlaceHolderProfile({
    super.key,
    this.img,
    required this.imgIconWidget,
    this.trailingWidget,
    this.titleWidget,
    required this.subTitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imgIconWidget,
      title: titleWidget,
      subtitle: subTitleWidget,
      trailing: trailingWidget,
    );
  }
}

Widget titleRow(String nameText) {
  return Row(
    children: [
      Text(
        nameText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 5),
      Icon(Icons.verified_outlined),
    ],
  );
}

Widget circleAvatarWidget(String img) {
  return CircleAvatar(radius: 30, backgroundImage: AssetImage(img));
}

Widget subTitleWidget(context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      // width: MediaQuery.of(context).size.width * 0.35,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditprofileScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // remove bg
          shadowColor: Colors.transparent, // remove shadow
          surfaceTintColor: Colors.transparent, // remove Material tint
          elevation: 0, // remove elevation
          padding: EdgeInsets.zero, // <-- removes button padding
          minimumSize: Size(0, 0), // <-- removes forced minimum size
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // <-- align content to top
          mainAxisSize: MainAxisSize.min, // <-- prevents expansion
          // mainAxisSize: MainAxisSize.,
          children: [
            Icon(Icons.edit_outlined, color: Colors.white),
            Text("Edit Profile", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}
