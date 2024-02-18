
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/Edit.dart';
import 'package:novelt_front/screens/GalleryImage.dart';
import 'package:novelt_front/screens/GalleryVideo.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/LoadingScreen.dart';
import 'package:novelt_front/screens/LoginSignupScreenState.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:novelt_front/screens/SelectScene.dart';
import 'package:novelt_front/screens/ShareShorts.dart';
import 'package:novelt_front/screens/ShowGalleryVideo.dart';
import 'package:novelt_front/screens/ShowGalleryImages.dart';


void main(){
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: ShareShorts(),
    );
  }
}
