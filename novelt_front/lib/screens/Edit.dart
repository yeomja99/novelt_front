import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novelt_front/screens/SelectScene.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

// 장면 번호랑 자막

class Edit extends StatefulWidget {
  final int selectedImageIndex;
  final int sceneNumber;
  final String sceneSubtitle;
  final String imageUrl;

  const Edit({
    Key? key,
    required this.selectedImageIndex,
    required this.sceneNumber,
    required this.sceneSubtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit>
    with SingleTickerProviderStateMixin {

  final editController = TextEditingController();
  late TextEditingController subtitleeditController;

  String edittext = "";
  // 수정하기
  Future<void> _sendDataToServer() async {
    // editController의 텍스트가 비어있는지 확인
    if (editController.text.isEmpty) {
      // 텍스트가 비어있다면 경고 메시지를 표시하고 함수를 종료
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("수정 사항을 입력해주세요."),
        ),
      );
      return;
    }

    // POST 요청을 보낼 URL
    const String apiUrl = 'http://your-fastapi-server.com/your-api-endpoint';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'sceneNumber': widget.sceneNumber,
          'editText': editController.text,
        }),
      );

      if (response.statusCode == 200) {
        // 서버 응답 처리
        print("Data successfully sent to the server");
        // 성공 메시지 표시 등...
      } else {
        // 오류 처리
        print("Failed to send data");
        // 오류 메시지 표시 등...
      }
    } catch (e) {
      print(e);
      // 예외 처리
    }
  }
  // 저장하기
  Future<void> _sendDataToBackend() async {
    // 백엔드 API 엔드포인트 URL
    const String apiUrl = 'http://your-fastapi-server.com/your-api-endpoint';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sceneNumber': widget.sceneNumber,
          'sceneSubtitle': subtitleeditController.text,
        }),
      );

      if (response.statusCode == 200) {
        // 요청 성공 처리
        print("Data successfully sent to the server");
      } else {
        // 서버 오류 처리
        print("Failed to send data: ${response.body}");
      }
    } catch (e) {
      // 네트워크 오류 처리
      print("Error sending data: $e");
    }
  }

  int _selectedIndex = 1;

  @override
  void initState() {
    subtitleeditController = TextEditingController(text: widget.sceneSubtitle);
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    subtitleeditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRAILER',
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
      backgroundColor: Colors.white,
      // bottomNavigationBar: SizedBox(
      //   height: 70,
      //   child: TabBar(controller: _tabController, tabs: const <Widget>[
      //     Tab(
      //       icon: Icon(
      //         Icons.grid_on,
      //         color: Colors.black,
      //         size:28,
      //       ),
      //     ),
      //     Tab(
      //       icon: Icon(
      //         Icons.add_circle,
      //         color: Colors.deepPurpleAccent,
      //         size: 42,
      //       ),
      //     ),
      //     Tab(
      //       icon: Icon(
      //         Icons.person,
      //         color: Colors.black,
      //         size: 32,
      //       ),
      //     )
      //   ]),
      // ),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,top:15),
            child: Text('장면 번호: ${widget.sceneNumber}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),),),

          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: 195,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16, // 이미지의 비율을 16:9로 유지합니다.
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover, // 이미지가 부모의 경계에 맞게 조정됩니다.
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5), // 반투명 오버레이
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    right: 20,
                    child: TextFormField(
                      controller: subtitleeditController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        // Text: widget.sceneSubtitle,
                        labelText: '자막 수정',
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.grey.shade800,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: 100,
              child: Center(
                child: TextFormField
                  ( onChanged: (text) {
                  setState(() {
                    edittext = text;
                  });
                },
                  decoration: InputDecoration(
                      labelText: '수정 사항을 입력해주세요 :)',
                      hintText: '예: 주인공을 조금 더 멋지게 그려주세요.',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: _sendDataToServer,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(170, 55),
                    backgroundColor: Color(0xfff0e0ff),
                    foregroundColor: Color(0xFF000000),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  child: const Text('수정하기')),
              ElevatedButton(
                  onPressed: () async {
                    if (subtitleeditController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("자막을 모두 입력해주세요."),
                        ),
                      );
                      return;
                    }

                    await _sendDataToBackend();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectScene()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(170, 55),
                    backgroundColor: Color(0xFF9156CA),
                    foregroundColor: Color(0xFFFFFFFF),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  child: const Text('저장하기')),
            ],),
        ],
      ),
      ),
    );
  }
}

