import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novelt_front/screens/SelectScene.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:novelt_front/services/ApiService.dart';

// 장면 번호랑 자막

class Edit extends StatefulWidget {
  int imgindex;
  int sceneNumber;
  String sceneSubtitle;
  String imageUrl;
  final int novelId;


  Edit({
    Key? key,
    required this.imgindex,
    required this.sceneNumber,
    required this.sceneSubtitle,
    required this.imageUrl,
    required this.novelId,
  }) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit>
    with SingleTickerProviderStateMixin {
  late int imgindex;
  final editController = TextEditingController();
  final subtitleeditController = TextEditingController();
  late String _imageUrl;
  late int _sceneNumber = widget.sceneNumber;

  String edittext = "";
  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl; // widget에서 전달받은 초기 값으로 설정
  }

  @override
  void dispose() {
    editController.dispose();
    subtitleeditController.dispose();
    super.dispose();
  }
  Future<void> _sendEditDataToBackend() async {
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
    const String apiUrl = baseUrl + 'scene_image/';
    print(widget.imgindex.toInt() + 1);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'novel_id': widget.novelId.toInt(),
          'edited_content': editController.text,
          'scene_id': widget.sceneNumber.toInt(),
          'img_id': widget.imgindex.toInt() + 1,
        }),
      );
      print('response body: ${response.body}');
      print('response statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        // 서버 응답 처리
        final responseBody = json.decode(response.body);
        final int newSceneNumber = responseBody['scenenumber'];
        final String newImgUrl = responseBody['image_url'];

        // 상태 업데이트 로직
        setState(() {
          _imageUrl = newImgUrl; // 여기서 직접 widget의 상태를 업데이트할 수 없으므로, 적절한 방식으로 상태를 관리해야 합니다.
          _sceneNumber = newSceneNumber; // 마찬가지로, 직접적인 상태 업데이트는 불가능
        });

        print("Data successfully sent to the server");
      } else {
        print("Failed to send data");
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> _sendSaveDataToBackend() async {
    const String apiUrl = baseUrl+'save_narr/'; // 백엔드 API 엔드포인트
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'novel_id': widget.novelId.toInt(),
          'scene_id': _sceneNumber.toInt(), // _sceneNumber를 사용하거나 widget.sceneNumber에 따라
          'narr': subtitleeditController.text,
        }),
      );
      print("response body: ${response.body}");

      if (response.statusCode == 200) {
        // 요청 성공 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("저장 성공!")),
        );
        // 성공적으로 데이터를 저장한 후의 로직을 여기에 추가합니다.
        // 예를 들어, 새로운 화면으로 네비게이션을 할 수 있습니다.
      } else {
        // 서버 오류 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("저장 실패: ${response.body}")),
        );
      }
    } catch (e) {
      // 네트워크 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("저장 실패: $e")),
      );
    }
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
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,top:15),
            child: Text('장면 설명',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),),),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('장면 설명: ${widget.sceneSubtitle}',
              style: TextStyle(
                fontSize: 18,
              ),),),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              // 배경 이미지
              Image.network(
                _imageUrl.startsWith('http')
                    ? _imageUrl
                    : baseUrl + _imageUrl,
                height: 300,
                fit: BoxFit.cover, // 이미지가 컨테이너에 꽉 차도록 조정합니다.
              ),

              // 텍스트 입력 필드
              SizedBox(height: 5,),
              Positioned(
                // bottom: 50, // 이미지 하단에서 50만큼 위에 위치
                left: 20, // 왼쪽 여백
                right: 20, // 오른쪽 여백
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: TextField(
                    maxLength: 40,
                    controller: subtitleeditController,
                    style: TextStyle(color: Colors.white), // 입력 텍스트 색상을 흰색으로 설정
                    decoration: InputDecoration(
                      hintText: widget.sceneSubtitle,
                      labelText: '자막을 입력해주세요',
                      labelStyle: TextStyle(color: Colors.grey), // 라벨 텍스트 색상을 흰색으로 설정
                      fillColor: Colors.grey.shade800, // 입력 필드 배경색
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none, // 테두리 없앰
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: 100,
              child: Center(
                child: TextField(
                  controller: editController,
                  onChanged: (text) {
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
                  onPressed: _sendEditDataToBackend,
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
                    _sendSaveDataToBackend();
                    Navigator.pop(context, {
                      'isSaved': true,
                      'imageUrl': _imageUrl,
                      'sceneNumber': _sceneNumber,
                      // 'editSubtitle': subtitleeditController.text,
                      'editSubtitle':widget.sceneSubtitle,
                    });
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

