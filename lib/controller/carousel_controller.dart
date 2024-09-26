import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselControllerProvider extends ChangeNotifier {
  final CarouselSliderController controller = CarouselSliderController();
  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void animateToPage(int page) {
    controller.animateToPage(page);
    setCurrentIndex(page);
  }
}
