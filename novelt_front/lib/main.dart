import 'package:flutter/material.dart';
import 'package:novelt_front/screens/MyPage.dart';
import 'package:novelt_front/screens/GalleryPage.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/SelectScene.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectScene(),
    );
  }
}
