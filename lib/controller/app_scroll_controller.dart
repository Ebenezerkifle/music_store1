import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AppScrollController extends GetxController {
  final scrollDiraction = ScrollDirection.forward.obs; //scroll diraction
  final offset = 50.0.obs; // default offset value.
  final ScrollController scrollController = ScrollController();
  final floatingButtonVisibility = false.obs;
  final bottomNavVisibility = true.obs;

  void scrollToTop() {
    // a method to bring the top element of a scrollable widget.
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      // maxScrollExtent - down most.
      // minScrollExtent - up most.
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
    floatingButtonVisibility(false);
  }

  void updateFloatingButtonVisibility() {
    floatingButtonVisibility(!floatingButtonVisibility.value);
  }

  void initState() {
    scrollController.addListener(() {
      //scroll listener
      // double showoffset = 40.0;
      //Back to top button(floating action button) will show on scroll offset 40.0
      //Bottom Navigation button will get hide on scroll offset 40.0.
      if (scrollController.offset > offset.value) {
        floatingButtonVisibility(true);
        bottomNavVisibility(false);
      } else {
        floatingButtonVisibility(false);
        bottomNavVisibility(true);
      }
    });
  }
}
