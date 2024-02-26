import 'package:flutter/material.dart';
import 'package:novelt_front/screens/Edit.dart';
import 'package:novelt_front/screens/GalleryImage.dart';
import 'package:novelt_front/screens/GalleryVideo.dart';
import 'package:novelt_front/screens/LoginSignupScreenState.dart';
import 'package:novelt_front/screens/MyPage.dart';
import 'package:novelt_front/screens/GalleryPage.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/Navigation.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:novelt_front/screens/SelectScene.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginSignupScreen(),
      // home: Edit(
      //   sceneNumber: 1,
      //   sceneSubtitle: "윤현우",
      //   selectedImageIndex: 1,
      //   imageUrl: 'https://media.discordapp.net/attachments/1193805310410899538/1209730264834514964/asap_009998_Middle_ages_romance_fantsy_An_old_duke_with_a_bruis_5e99155a-ac13-49a4-a2a6-e493303e816a.png?ex=65e7fc1a&is=65d5871a&hm=be3f851ec5ef7dbca2c338310f56e70e14111de5c9a7b7f357bc02ef487222bb&=&format=webp&quality=lossless&width=294&height=525',
      //   novelId: 1,
      // ),
    );
  }
}
