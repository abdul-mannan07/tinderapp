import 'dart:async';
import 'package:flutter/foundation.dart';

class ImageSliderProvider with ChangeNotifier {
  final List<String> imagesAddress = [
    "assets/search/youngwoman2.jpg",
    "assets/search/girls.png",
    "assets/search/top.png",
  ];

  int _currentIndex = 0;
  Timer? _timer;

  int get currentIndex => _currentIndex;

  /// Start the auto-changing timer
  void startAutoSlide() {
    // Prevent multiple timers
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      nextImage();
    });
  }

  /// Go to next image
  void nextImage() {
    _currentIndex = (_currentIndex + 1) % imagesAddress.length;
    notifyListeners();
  }

  /// Stop the timer (important to avoid memory leaks)
  void stopAutoSlide() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
