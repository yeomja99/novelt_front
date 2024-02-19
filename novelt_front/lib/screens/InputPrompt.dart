import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SelectScene.dart';

import 'GalleryImage.dart';
import 'LoadingScreen.dart';
import 'MyPage.dart';

class InputPrompt extends StatefulWidget {
  InputPrompt({Key? key}) : super(key: key);

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> with TickerProviderStateMixin {
  late TabController _tabController1;
  int _selectedIndex1 = 1;
  List<Widget> containerList = []; // 동적으로 추가될 Container 리스트


  @override
  void initState() {
    super.initState();
    setState(() {
      _selectValue = genrelist[0];
    });
    _tabController1 = TabController(length: 3, vsync: this);
    // _tabController1에 대한 리스너 설정
    _tabController1.addListener(() {
      if (_tabController1.indexIsChanging) {
        // _tabController2의 인덱스 변경이 완료되었는지 확인
        return;
      }
      if (_tabController1.index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GalleryImage()));
      }
      else if (_tabController1.index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyPage()));
      }

      setState(() {
        _selectedIndex1 = _tabController1.index; // 선택된 탭 인덱스 업데이트
      });
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
                  child: TextField(
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
                            _selectValue = newValue!;
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
                  child: TextField(
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
                Container(
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
                            child: TextField(
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
                            child: TextField(
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
                              onChanged: (_) {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      TextField(
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
                      TextField(
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
                      TextField(
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
                      TextField(
                        decoration: InputDecoration(
                          labelText: '외형',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    onPressed: () {
                      setState(() {
                        containerList.add(createCharacterContainer()); // 새 Container 추가
                      });
                      // 버튼이 눌렸을 때 실행할 기능
                    },
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
                      onPressed: () {
                        // LoadingScreen으로 네비게이션
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectScene()),
                        );
                        // 버튼이 눌렸을 때 실행할 기능
                      },
                      child: Text('제출하기'), // 버튼 텍스트 설정
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
    );
  }
}