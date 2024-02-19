import 'package:flutter/material.dart';

class AppController {
  static final AppController _instance = AppController._internal();
  factory AppController() => _instance;

  AppController._internal();

  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier(1);
  final ValueNotifier<int> galleryTabIndex = ValueNotifier(0); // GalleryPage의 탭 인덱스


  void setSelectedIndex(int index) {
    selectedIndexNotifier.value = index;
  }
  void setGalleryTabIndex(int index) {
    galleryTabIndex.value = index;
  }
}

