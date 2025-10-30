import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/classes/browsing_classes.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/settings_language_screen.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/show_me_screen.dart';

class SettingScreen extends StatefulWidget {
  final String? selectedText;
  const SettingScreen({super.key, this.selectedText});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double distance = 0;
  double startAge = 18;
  double endAge = 75;
  RangeValues _currentRangeValues = const RangeValues(18, 75);

  Language _selectedLanguageObj = Languages.english;

  String selectedLanguage = "English";
  String currentLocation = "Unknown";
  bool isValue = false;
  bool isValueD = false;
  bool isValueA = false;

  List<String> detail = [
    "Get Super Likes",
    "Get Boots",
    "Go Incognito",
    "Passport Mode",
  ];
  List<Widget> icons = [
    Icon(Icons.star, color: Colors.amber),
    Icon(Icons.flash_on, color: Colors.purple),
    Icon(Icons.visibility_off, color: Colors.black),
    Icon(Icons.local_airport, color: Colors.pink),
  ];
  List<Color> textColor = [
    Colors.amber,
    Colors.purple,
    Colors.black,
    Colors.pink,
  ];

  void _openLanguagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => LanguagePickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: Colors.pink,
        searchInputDecoration: const InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: const Text('Select your language'),
        onValuePicked: (Language language) {
          setState(() {
            selectedLanguage = language.name;
          });
        },
        itemBuilder: _buildDialogItem,
      ),
    );
  }

  Widget _buildDialogItem(Language language) {
    return Row(
      children: <Widget>[
        Text(language.name),
        const SizedBox(width: 8),
        Flexible(child: Text("(${language.isoCode})")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 4, title: const Text("Setting")),
        body: Center(
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.95,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  PlaceholderMemberShip(
                    iconColor: Colors.black,
                    pallalogramBox: BrowsingClasses().firstWidget(
                      Colors.black,
                      Colors.white,
                    ),
                    textDesc: "See who you Like & More",
                  ),
                  const SizedBox(height: 10),
                  PlaceholderMemberShip(
                    iconColor: Colors.amber,
                    pallalogramBox: BrowsingClasses().firstWidget(
                      Colors.amber,
                      Colors.white,
                    ),
                    textDesc: "Piriority Likes, See who you Like & More",
                  ),
                  const SizedBox(height: 10),
                  PlaceholderMemberShip(
                    iconColor: Colors.red,
                    pallalogramBox: const Icon(Icons.add, color: Colors.red),
                    textDesc: "Unlimited Like & More",
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 202,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 1.7,
                          ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BrowsingClasses().myBoxDecoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BrowsingClasses().myBoxDecoration,
                                child: icons[index],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                detail[index],
                                style: TextStyle(
                                  color: textColor[index],
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Account Setting",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Phone Number"),
                          Row(
                            children: const [
                              Text("3137545987"),
                              Icon(Icons.arrow_forward_ios_rounded, size: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Verify a Phone Number to help Secure your account",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Discovery Settings",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 70,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.pink),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  currentLocation,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow
                                      .ellipsis, // prevents overflow if location is long
                                ),
                              ),
                              const SizedBox(width: 10),
                              LocationPromptWidget(
                                onLocationSelected: (location) {
                                  setState(() {
                                    currentLocation = location;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  BrowsingClasses().textAlign(
                    "Change Location to see matches in other cities",
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Global",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              //  fontSize: 15
                            ),
                          ),
                          //SizedBox(height: 5),
                          Switch(
                            inactiveThumbColor: Colors.pink,
                            activeThumbColor: Colors.pink,
                            value: isValue,
                            onChanged: (context) {
                              setState(() {
                                isValue = !isValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BrowsingClasses().textAlign(
                    "Going global to match with people around the world",
                  ),
                  Container(
                    height: 150,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Preffered Language",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              //  fontSize: 15
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedLanguage,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  // Navigate and wait for selected language
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SettingsLanguageScreen(
                                            selectedLanguage:
                                                _selectedLanguageObj,
                                          ),
                                    ),
                                  );

                                  if (result != null && result is Language) {
                                    setState(() {
                                      _selectedLanguageObj = result;
                                      selectedLanguage = result.name;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey, height: 1),
                          TextButton(
                            onPressed: _openLanguagePickerDialog,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Add Language",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 150,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Maximum Distance",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    //  fontSize: 15
                                  ),
                                ),
                              ),
                              Text(
                                "${distance.toStringAsFixed(0)} miles",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            activeColor: Colors.pink,
                            // inactiveColor: Colors.grey,
                            value: distance,
                            min: 0,
                            max: 150,
                            divisions: 150,
                            label: "${distance.toStringAsFixed(0)} miles",
                            onChanged: (double value) {
                              setState(() {
                                distance = value;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Show people further away if I run out of profiles to see",
                                ),
                              ),
                              Switch(
                                inactiveThumbColor: Colors.pink,
                                activeThumbColor: Colors.pink,
                                value: isValueD,
                                onChanged: (context) {
                                  setState(() {
                                    isValueD = !isValueD;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BrowsingClasses()
                        .myBoxDecoration, // your gradient, border, shadow, rounded corners, etc.
                    child: Material(
                      color: Colors.transparent, // so ripple is visible
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // match your decoration corners
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Colors.pink.withOpacity(
                          0.3,
                        ), // ripple color
                        highlightColor: Colors.pink.withOpacity(
                          0.1,
                        ), // tap highlight
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowMeScreen(),
                            ),
                          );
                          print("Card tapped!");
                        },
                        child: Container(
                          height: 70,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Show Me",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.selectedText ?? 'Woman',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    decoration: BrowsingClasses().myBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Age Range",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    //  fontSize: 15
                                  ),
                                ),
                              ),
                              Text(
                                " ${_currentRangeValues.start.toInt()} - ${_currentRangeValues.end.toInt()}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          RangeSlider(
                            activeColor: Colors.pink,

                            min: 18,
                            max: 75,
                            divisions: 75 - 18,
                            values: _currentRangeValues,
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                                startAge = values.start;
                                endAge = values.end;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Show people Slightly out of my preferred range if i run out of profiles to see",
                                ),
                              ),
                              Switch(
                                inactiveThumbColor: Colors.pink,
                                activeThumbColor: Colors.pink,
                                value: isValueA,
                                onChanged: (context) {
                                  setState(() {
                                    isValueA = !isValueA;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
