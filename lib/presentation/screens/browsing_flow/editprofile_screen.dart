import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: Text("Edit Profile"),
            bottom: TabBar(
              dividerHeight: 2,
              dividerColor: Colors.grey,
              indicatorColor: Colors.pink,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "Edit"),
                Tab(text: "Preview"),
              ],
            ),
          ),
          body: TabBarView(children: [EditTab(), Text("data2")]),
        ),
      ),
    );
  }
}

class EditTab extends StatefulWidget {
  const EditTab({super.key});

  @override
  State<EditTab> createState() => _EditTabState();
}

class _EditTabState extends State<EditTab> {
  List<String> lifeStyleList = ["Pets", "Smoking", "Drinking", "Workout"];
  List<IconData> lifeStyleIcons = [
    Icons.pets,
    Icons.smoking_rooms,
    Icons.local_drink_outlined,
    Icons.fitness_center,
  ];
  List<String> lifeStyleTrailing = [
    "Cat",
    "Trying to quit",
    "Not for me",
    "Often",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Media",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 340,
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 100 / 150, // width / height
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      DottedBorder(
                        radius: const Radius.circular(12),
                        borderType: BorderType.RRect,
                        dashPattern: const [6, 3],
                        color: Colors.grey,
                        strokeWidth: 1.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            //height: 100,
                            // width: 100,
                            color: Colors.amber,
                          ),
                        ),
                      ),

                      Positioned(
                        top: -8, // move slightly above the dotted border
                        right: -8,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: const Icon(
                              Icons.edit,
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

            Text(
              "Relationship Goals",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CustomeListtile.single(
              //  items: 1,
              leadingIcon: Icons.visibility_outlined,
              titleText: "Looking for",
              trailingText: "New Friends",
            ),
            SizedBox(height: 10),
            Text(
              "Life style",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CustomeListtile.multiple(
              leadingIcons: lifeStyleIcons,
              titles: lifeStyleList,
              trailingTexts: lifeStyleTrailing,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeListtile extends StatelessWidget {
  final List<IconData> leadingIcons;
  final List<String> titles;
  final List<String> trailingTexts;

  /// If you pass a single item, just wrap it in a list.
  CustomeListtile.single({
    super.key,
    required IconData leadingIcon,
    required String titleText,
    required String trailingText,
  }) : leadingIcons = [leadingIcon],
       titles = [titleText],
       trailingTexts = [trailingText];

  /// For multiple items, pass lists directly
  const CustomeListtile.multiple({
    super.key,
    required this.leadingIcons,
    required this.titles,
    required this.trailingTexts,
  }) : assert(
         leadingIcons.length == titles.length &&
             titles.length == trailingTexts.length,
         "All lists must have the same length",
       );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Important inside Column / SingleChildScrollView
      physics: NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              leading: Icon(leadingIcons[index], color: Colors.grey),
              title: Text(titles[index], style: TextStyle(fontSize: 16)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(trailingTexts[index], style: TextStyle(fontSize: 15)),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                    //  color: Colors.grey,
                  ),
                  // Icon(
                  //   Icons.arrow_forward_ios_rounded,
                  //   color: Colors.grey,
                  //   size: 16,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
