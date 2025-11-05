import 'package:flutter/material.dart';

class HomeArrowProvider with ChangeNotifier {
  // Track current picture index per profile
  final Map<int, int> _currentIndexes = {};

  // Track icon flags per profile
  final Map<int, Map<String, bool>> _profileFlags = {};

  /// Get current index for a profile
  int currentIndex(int profileIndex) => _currentIndexes[profileIndex] ?? 0;

  /// Get icon flag for a profile
  bool flag(int profileIndex, String iconName) =>
      _profileFlags[profileIndex]?[iconName] ?? false;

  /// Cycle to next picture for a profile
  void showNextPic(int profileIndex, int totalPics) {
    _currentIndexes[profileIndex] =
        ((currentIndex(profileIndex) + 1) % totalPics);
    notifyListeners();
  }

  /// Handle icon taps for a profile
  void iconTap(int profileIndex, String iconName) {
    _profileFlags[profileIndex] ??= {
      'refresh': false,
      'close': false,
      'star': false,
      'fav': false,
      'sent': false,
    };

    // Reset all flags
    _profileFlags[profileIndex]!.updateAll((key, value) => false);

    // Set tapped icon
    if (_profileFlags[profileIndex]!.containsKey(iconName)) {
      _profileFlags[profileIndex]![iconName] = true;
    }

    notifyListeners();
  }

  /// Reset all flags for a profile
  void resetFlags(int profileIndex) {
    if (_profileFlags[profileIndex] != null) {
      _profileFlags[profileIndex]!.updateAll((key, value) => false);
      notifyListeners();
    }
  }
}
