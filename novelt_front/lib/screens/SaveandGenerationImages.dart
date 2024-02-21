import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/ShowGalleryImages.dart';

import 'AppController.dart';
import 'GalleryPage.dart';
import 'LoadingScreen.dart';
import 'Navigation.dart';
import 'package:http/http.dart' as http;


class SaveandGenerationImages extends StatefulWidget {
  SaveandGenerationImages({super.key});

  @override
  State<SaveandGenerationImages> createState() => _SaveandGenerationImagesState();
}

class _SaveandGenerationImagesState extends State<SaveandGenerationImages> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  // API 호출 결과를 저장할 변수
  String apiResponse = '';

  // 이미지 저장 API 호출 함수
  Future<void> callImageSaveAPI() async {
    const String apiUrl = 'https://your-api-url.com/endpoint';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'key': 'value', // 필요한 요청 본문 데이터
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받았을 때의 처리
        setState(() {
          apiResponse = 'API 호출 성공: ${response.body}';
        });
      } else {
        // 서버 에러 처리
        setState(() {
          apiResponse = 'API 호출 실패: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 네트워크 에러 처리
      setState(() {
        apiResponse = 'API 호출 중 에러 발생: $e';
      });
    }
  }

  // 비디오 저장 API 호출 함수
  Future<void> callVideoSaveAPI() async {
    const String apiUrl = 'https://your-api-url.com/endpoint';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'key': 'value', // 필요한 요청 본문 데이터
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받았을 때의 처리
        setState(() {
          apiResponse = 'API 호출 성공: ${response.body}';
        });
      } else {
        // 서버 에러 처리
        setState(() {
          apiResponse = 'API 호출 실패: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 네트워크 에러 처리
      setState(() {
        apiResponse = 'API 호출 중 에러 발생: $e';
      });
    }
  }

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
                          callImageSaveAPI();
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
                          callVideoSaveAPI();
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
                        child: const Text('숏폼 생성하러 가기')),
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