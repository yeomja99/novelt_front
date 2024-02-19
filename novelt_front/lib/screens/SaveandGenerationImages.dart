import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/ShowGalleryImages.dart';

import 'AppController.dart';
import 'GalleryPage.dart';
import 'LoadingScreen.dart';
import 'Navigation.dart';

class SaveandGenerationImages extends StatelessWidget {
  SaveandGenerationImages({super.key});

  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CREATE TRAILER',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF9a7eff), // Left side color
                Color(0xFFbe82f4), // Right side color, change to desired color
              ],
            ),
          ),
        ),// Adds a shadow below the AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Icon(Icons.check_circle_rounded,
                        size:100),
                    SizedBox(height: 10,),
                    Text('이미지 생성 완료!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 50
                      ,),
                    ElevatedButton(
                        onPressed: () {
                          AppController().setSelectedIndex(0); // `GalleryPage`가 있는 메인 네비게이션 인덱스
                          AppController().setGalleryTabIndex(0); // `GalleryVideo` 탭 인덱스
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavigationPage()));
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(340, 55),
                          backgroundColor: Color(0xFFE460EF),
                          foregroundColor: Color(0xFFFFFFFF),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        child: const Text('이미지 저장하기')),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: () {
                          AppController().setSelectedIndex(0); // `GalleryPage`가 있는 메인 네비게이션 인덱스
                          AppController().setGalleryTabIndex(1); // `GalleryVideo` 탭 인덱스
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavigationPage()));
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(340, 55),
                          backgroundColor: Color(0xFF9156CA),
                          foregroundColor: Color(0xFFFFFFFF),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        child: const Text('쇼츠 생성하러 가기')),
                    SizedBox(height: 5,),

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}