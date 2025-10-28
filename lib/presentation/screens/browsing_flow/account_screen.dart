import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Widget> icons = [
    Icon(Icons.star, color: Colors.blueAccent),
    Icon(Icons.flash_on, color: Colors.purple),
    Icon(Icons.local_fire_department, color: Colors.pink),
  ];
  List<String> imagesAddress = [
    "assets/search/youngwoman1.jpg",
    "assets/search/girls.png",
    "assets/search/top.png",
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          titleSpacing: 5,
          // centerTitle: true,
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
                    onPressed: () {},
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            PlaceHolderProfile(
              titleWidget: titleRow("Barbra"),
              imgIconWidget: circleAvatarWidget("assets/search/club.png"),
              subTitleWidget: subTitleWidget(context),
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
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // mainAxisSpacing: 5,
                  childAspectRatio: 1, // Adjust for a taller box shape
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
                                        text: " Super Likes\n",
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
                          height: 24, // set the circle size explicitly
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Image.asset(
                  imagesAddress[currentIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imagesAddress.length, (index) {
                  return Container(
                    width: 7,
                    height: 7,
                    margin: EdgeInsets.symmetric(
                      horizontal: 2,
                    ), // spacing between parts
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceHolderProfile extends StatelessWidget {
  final String? img;
  // final String nameText;
  // final Widget newWidget;
  final Widget imgIconWidget;
  final Widget? trailingWidget;
  final Widget? titleWidget;
  final Widget? subTitleWidget;
  const PlaceHolderProfile({
    super.key,
    this.img,
    //required this.nameText,
    // required this.newWidget,
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
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_outlined, color: Colors.white),
          Text("Edit Profile", style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
