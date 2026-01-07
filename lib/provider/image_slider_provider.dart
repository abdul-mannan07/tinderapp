import 'dart:async';
import 'package:flutter/material.dart';

class ImageSliderProvider extends ChangeNotifier {
  List<String> imagesAddress = [
    'assets/search/club.png',
    'assets/search/clubdj.png',
    'assets/search/girls.png',
    'assets/search/youngwoman1.jpg',
    'assets/search/youngwoman2.jpg',
  ];

  int currentIndex = 0;
  Timer? _timer;

  // Start auto slide
  void startAutoSlide() {
    _timer?.cancel(); // cancel previous timer
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      nextImage();
    });
  }

  // Stop auto slide
  void stopAutoSlide() {
    _timer?.cancel();
  }

  // Go to next image
  void nextImage() {
    currentIndex = (currentIndex + 1) % imagesAddress.length;
    notifyListeners();
  }

  // Go to previous image
  void previousImage() {
    currentIndex =
        (currentIndex - 1 + imagesAddress.length) % imagesAddress.length;
    notifyListeners();
  }

  // Go to specific index
  void goToIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
