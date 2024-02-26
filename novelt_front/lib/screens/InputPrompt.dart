import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SelectScene.dart';
import 'package:novelt_front/services/ApiService.dart';

import '../models/ChracterInfo.dart';
import '../models/novel_data.dart';
import 'GalleryImage.dart';
import 'LoadingScreen.dart';
import 'MyPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NovelData {
  final int novelId;
  final List<SceneData> noveldata;

  NovelData({required this.novelId, required this.noveldata});

  factory NovelData.fromJson(Map<String, dynamic> json) {
    var list = json['noveldata'] as List;
    List<SceneData> novelDataList = list.map((i) => SceneData.fromJson(i)).toList();

    return NovelData(
      novelId: json['novel_id'],
      noveldata: novelDataList,
    );
  }
}

class SceneData {
  final String subtitle;
  final int sceneNumber;
  final List<String> imgUrls;

  SceneData({required this.subtitle, required this.sceneNumber, required this.imgUrls});

  factory SceneData.fromJson(List<dynamic> json) {
    List<String> imgUrls = List<String>.from(json[2]);
    return SceneData(
      subtitle: json[0],
      sceneNumber: json[1],
      imgUrls: imgUrls,
    );
  }
}

class InputPrompt extends StatefulWidget {
  InputPrompt({Key? key}) : super(key: key);

  @override
  State<InputPrompt> createState() => _InputPromptState();
}
class _InputPromptState extends State<InputPrompt> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<SelectNovelData?> sendCharacterData(
      List<ChracterInfo> characters,
      String title,
      String genre,
      String story,
      String emphasis,) async {
    // FastAPI 서버의 엔드포인트 URL
    var url = Uri.parse(baseUrl + 'novel/');
    // 필터링된 캐릭터 정보를 담을 리스트
    List<Map<String, dynamic>> filteredCharacters = [];

    // Null 값이 아닌 필드만을 포함하도록 캐릭터 정보 필터링
    for (var character in characters) {
      Map<String, dynamic> characterData = {};

      // Null이 아닌 필드만 추가
      if (character.name.isNotEmpty) characterData['이름'] = character.name;
      if (character.age.isNotEmpty) characterData['나이'] = character.age;
      if (character.gender.isNotEmpty) characterData['성별'] = character.gender;
      if (character.personality.isNotEmpty) characterData['성격'] = character.personality;
      if (character.hairstyle.isNotEmpty) characterData['헤어스타일'] = character.hairstyle;
      if (character.clothes.isNotEmpty) characterData['의상'] = character.clothes;
      if (character.appearance.isNotEmpty) characterData['의향'] = character.appearance;
      if (character.appearance.isNotEmpty) characterData['img'] = character.imgurl;


      // 캐릭터 데이터가 비어있지 않다면 리스트에 추가
      if (characterData.isNotEmpty) filteredCharacters.add(characterData);
    }
    // POST 요청에 담을 데이터
    var data = {
      'novel':{
      '제목': title!,
      '장르': genre!,
      '강조요소': emphasis,
      '줄거리': story!},
      'characters': filteredCharacters

    };
    print("Data: $data");

    // HTTP POST 요청 보내기
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
    var decodedResponse = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(decodedResponse);
      SelectNovelData selectnovelData = SelectNovelData.fromJson(jsonResponse);
      print('Novel ID: ${selectnovelData.novelId}');
      for (var sceneData in selectnovelData.novelData) {
        print('Subtitle: ${sceneData.subtitle}, Scene Number: ${sceneData.sceneNumber}, Image URLs: ${sceneData.imageUrls}');
      }
      print('Data successfully sent to the server');
      return selectnovelData;
    } else {
      print('Failed to send data');
      return null;
    }
  }
    // null 값 검사
  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      // 폼이 유효하지 않으면 함수를 종료합니다.
      return;
    }
    _formKey.currentState!.save();
}

  late TabController _tabController1;
  int _selectedIndex1 = 1;
  List<Widget> containerList = []; // 동적으로 추가될 Container 리스트
  final TextEditingController titleController = TextEditingController();
  late String genreController = "";
  final TextEditingController storyController = TextEditingController();
  final TextEditingController emphasisController = TextEditingController();
  final TextEditingController charactername = TextEditingController(); // 필수
  final TextEditingController characterage = TextEditingController(); // 필수
  String? charactergender;
  final TextEditingController characterpersonality = TextEditingController(); // 필수
  final TextEditingController characterhairstyle = TextEditingController();
  final TextEditingController characterclothes = TextEditingController();
  final TextEditingController characterappearance = TextEditingController(); // 필수
  final TextEditingController characterimgurl = TextEditingController();

  List<ChracterInfo> Characters = [];

  void _addWidget() {
    setState(() {
      containerList.add(_createCharacterForm());
    });
  }
  void addNewCharacter() {
    final newCharacter = ChracterInfo(
      name: charactername.text!,
      age: characterage.text!,
      gender: charactergender ?? "",
      personality: characterpersonality.text!,
      hairstyle: characterhairstyle.text,
      clothes: characterclothes.text,
      appearance: characterappearance.text!,
      imgurl: characterimgurl.text,
    );

    // 리스트에 추가하고 상태 업데이트
    setState(() {
      Characters.add(newCharacter);
    });

    // 캐릭터를 추가한 후, 컨트롤러를 초기화하여 다음 입력을 준비합니다.
    charactername.clear();
    characterage.clear();
    characterpersonality.clear();
    characterhairstyle.clear();
    characterclothes.clear();
    characterappearance.clear();
  }
  Widget _createCharacterForm(){
    return Container(
      padding: EdgeInsets.all(23.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '등장인물',
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w100,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return '등장인물의 이름은 반드시 입력해야 합니다.';
                    }
                  },
                  controller: charactername,
                  decoration: InputDecoration(
                    labelText: '이름',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return '등장인물의 나이는 반드시 입력해야 합니다.';
                    }
                  },
                  controller: characterage,
                  decoration: InputDecoration(
                    labelText: '나이',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: '성별',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  items: <String>['남자', '여자'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      charactergender = value ?? "";
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          TextFormField(
            validator: (value){
              if (value == null || value.isEmpty){
                return '등장인물의 성격은 반드시 입력해야 합니다.';
              }
            },
            controller: characterpersonality,
            decoration: InputDecoration(
              labelText: '성격',
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: characterhairstyle,
            decoration: InputDecoration(
              labelText: '헤어',
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: characterclothes,
            decoration: InputDecoration(
              labelText: '의상',
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            validator: (value){
              if (value == null || value.isEmpty){
                return '등장인물의 외형은 반드시 입력해야 합니다.';
              }
            },
            controller: characterappearance,
            decoration: InputDecoration(
              labelText: '외형',
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            ),
          ),
        SizedBox(height: 20,),
          TextFormField(
            controller: characterimgurl,
            decoration: InputDecoration(
              labelText: '참고할 등장인물 이미지 url',
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            ),
          ),
        ],
      ),
    );

  }



  @override
  void initState() {
    super.initState();
    setState(() {
      _selectValue = genrelist[0];
    });
  }


  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  var genrelist = ['현대판 로맨스', '로맨스 판타지', '현대판 소설','판타지 소설','무협'];
  String? _selectValue = '';

  // 캐릭터 정보 Container 생성 함수
  Widget createCharacterContainer() {
    return Container(
      padding: EdgeInsets.all(23.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container 내용...
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5DEFF),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 1),
                Text(
                  '숏폼 제작을 위한 웹소설 정보를 입력해주세요.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return '소설의 제목은 반드시 입력해야 합니다.';
                      }
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      filled: true, // 필요한 경우 배경색을 사용하기 위해 true로 설정
                      fillColor: Color(0xFFF8F8FF), // 텍스트 필드 배경색 설정
                      labelText: '제목',
                      hintText: '제목을 입력하세요.',
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0), // 외부 패딩 조정
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8FF), // 드롭다운 배경색
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Color(0xFFF8F8FF), width: 1), // 테두리 색상과 두께 조정
                    boxShadow: [ // 그림자 효과 추가
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(0, 3), // 그림자의 위치 조정
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline( // 드롭다운 버튼의 기본 밑줄을 숨깁니다.
                    child: InputDecorator(
                      decoration: InputDecoration(
                        //labelText: '장르 선택', // 라벨이 필요한 경우 주석 해제
                        //labelStyle: TextStyle(color: Color(0xFFbe82f4), fontSize: 16), // 라벨 스타일 조정
                        border: InputBorder.none, // InputDecorator 경계선 제거
                        contentPadding: EdgeInsets.symmetric(vertical: 3.0), // 내부 패딩 조정
                      ),
                      child: DropdownButton<String>(
                        value: _selectValue,
                        isExpanded: true, // 드롭다운 메뉴를 컨테이너 너비에 맞게 확장
                        items: genrelist.map((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genreController = newValue ?? "";
                          });
                        },
                        style: TextStyle(color: Colors.black54, fontSize: 16), // 드롭다운 아이템 텍스트 스타일
                        dropdownColor: Color(0xFFF8F8FF), // 드롭다운 메뉴의 배경색
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(// 텍스트 필드 배경색
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2), // 그림자의 위치 조정
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return '소설의 줄거리는 반드시 입력해야 합니다.';
                      }
                    },
                    controller: storyController,
                    decoration: InputDecoration(
                      filled: true, // 필요한 경우 배경색을 사용하기 위해 true로 설정
                      fillColor: Color(0xFFF8F8FF), // 텍스트 필드 배경색 설정
                      labelText: '줄거리',
                      hintText: '줄거리를 입력하세요.',
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      contentPadding: EdgeInsets.only(top: 8.0, bottom: 100.0, left: 20.0, right: 20.0), // 위쪽 패딩 추가
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: TextField( // 두 번째 TextField를 추가합니다.
                    controller: emphasisController,
                    decoration: InputDecoration(
                      filled: true, // 필요한 경우 배경색을 사용하기 위해 true로 설정
                      fillColor: Color(0xFFF8F8FF), // 텍스트 필드 배경색 설정
                      labelText: '강조 포인트',
                      hintText: '강조 포인트를 입력하세요.',
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                for (int i = 0; i < containerList.length; i++) ...[
                  containerList[i],
                  if (i < containerList.length - 1)
                    SizedBox(height: 10), // 여기서 10은 간격의 크기입니다. 필요에 따라 조절하세요.
                ],
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8FF), // 버튼 배경색 설정
                    borderRadius: BorderRadius.circular(15.0), // 둥근 테두리 설정
                    border: Border.all(
                      color: Color(0xFFF8F8FF), // 테두리 색상 설정
                      width: 1, // 테두리 두께 설정
                    ),
                    boxShadow: [ // 그림자 효과 추가
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),

                  child: IconButton(
                    icon: Icon(Icons.add), // 플러스 아이콘 설정
                    color: Colors.black54, // 아이콘 색상 설정
                    onPressed: (){
                      setState(() {
                        _addWidget();
                        addNewCharacter();
                      });
                    },
                      // 버튼이 눌렸을 때 실행할 기능
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF9a7eff), // 배경색 설정
                    borderRadius: BorderRadius.circular(15.0), // 둥근 테두리 설정
                    boxShadow: [ // 그림자 효과 추가
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  // 버튼의 너비를 조정하기 위해 SizedBox로 감쌉니다.
                  child: SizedBox(
                    width: 340, // 버튼의 너비를 200으로 설정
                    height: 50, // 버튼의 높이를 50으로 설정 (선택적)
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF9a7eff), // 버튼 배경색 설정
                        onPrimary: Colors.white, // 버튼 텍스트 색상 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // 버튼의 둥근 테두리 설정
                        ),
                        elevation: 3, // 그림자 깊이 설정
                      ),
                      onPressed: ()async {
                        if (_formKey.currentState!.validate()){
                          SelectNovelData? selectnovelData = await sendCharacterData(Characters,
                              titleController.text,
                              genreController,
                              storyController.text,
                              emphasisController.text);
                          _submitData();
                          if (selectnovelData != null) {
                            print("novel Data is here");
                            // novelData가 성공적으로 받아진 경우, SelectScene으로 네비게이션하면서 novelData 전달
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectScene(novelData: selectnovelData),
                              ),
                            );
                          } else {
                            // 서버로부터 응답이 null인 경우(오류 발생), 적절한 오류 처리 수행
                            print("Failed to load novel data");
                          }
                        } else {
                          print("Form validation failed");
                        }
                      },
                      child: Text('제출하기'), // 버튼 텍스트 설정
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}