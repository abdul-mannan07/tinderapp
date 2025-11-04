import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinderapp/presentation/screens/models/model_class.dart';

class HomeProvider with ChangeNotifier {
  // 🔹 Use typed model list
  List<Profile> profile = [
    Profile(
      name: "Barbra Charley",
      pics: [
        "assets/search/top.png",
        "assets/search/youngwoman1.jpg",
        "assets/search/youngwoman2.jpg",
        "assets/search/youngwoman1.jpg",
      ],
      descp: "Positioned(bottom: 20) keeps the entire column near the bottom.",
    ),
    Profile(
      name: "Alice Smith",
      pics: [
        "assets/search/youngwoman2.jpg",
        "assets/search/youngwoman1.jpg",
      ],
      descp: "Let me know if you'd like me to refactor your full Stack layout for clarity.",
    ),
  ];

  bool _isForYouScreen = true;
  int _currentProfileIndex = 0;
  List<int> _currentIndexes = [];
  late List<Map<String, bool>> _profileFlags;
  bool _buttonFlag = false;

  bool get isForYouScreen => _isForYouScreen;
  int get currentProfileIndex => _currentProfileIndex;
  List<int> get currentIndexes => _currentIndexes;
  List<Map<String, bool>> get profileFlags => _profileFlags;
  bool get buttonFlag => _buttonFlag;

  // 🔹 Cycle through pictures of a profile
  void showPics(int profileIndex) {
    final pics = profile[profileIndex].pics;
    if (_currentIndexes[profileIndex] < pics.length - 1) {
      _currentIndexes[profileIndex]++;
    } else {
      _currentIndexes[profileIndex] = 0;
    }
    notifyListeners();
  }

  void toggleScreen(bool showForYou) {
    _isForYouScreen = showForYou;
    notifyListeners();
  }

  void profileFlagSetup() {
    _currentIndexes = List.filled(profile.length, 0);
    _profileFlags = List.generate(profile.length, (index) {
      return {
        'refresh': false,
        'close': false,
        'star': false,
        'fav': false,
        'sent': false,
      };
    });

    Future.microtask(() {
      notifyListeners();
      loadFlags();
    });
  }

  Future<void> loadFlags() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('profileFlags');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      _profileFlags = jsonData
          .map<Map<String, bool>>((e) => Map<String, bool>.from(e))
          .toList();
    }
    notifyListeners();
  }

  Future<void> saveFlags() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(_profileFlags);
    await prefs.setString('profileFlags', jsonString);
    notifyListeners();
  }

  void iconTap(String iconName, int profileIndex) {
    if (profileIndex >= 0 && profileIndex < _profileFlags.length) {
      _profileFlags[profileIndex].updateAll((key, value) => false);
      _profileFlags[profileIndex][iconName] = true;
      saveFlags();
    }
    notifyListeners();
  }

  void showBorder() {
    _buttonFlag = !_buttonFlag;
    notifyListeners();
  }

  void setCurrentProfileIndex(int index) {
    _currentProfileIndex = index;
    notifyListeners();
  }

  void resetProfilePicIndex(int index) {
    _currentIndexes[index] = 0;
    notifyListeners();
  }

  void refreshDeck() async {
    // Shuffle the profiles
    profile.shuffle();

    // Reset indices
    _currentProfileIndex = 0;
    _currentIndexes = List.filled(profile.length, 0);

    // Reset flags
    _profileFlags = List.generate(profile.length, (_) {
      return {
        'refresh': false,
        'close': false,
        'star': false,
        'fav': false,
        'sent': false,
      };
    });

    // Clear saved flags
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileFlags');

    notifyListeners();
  }
}
