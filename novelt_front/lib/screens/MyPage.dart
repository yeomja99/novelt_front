import 'package:flutter/material.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';
import 'GalleryImage.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with TickerProviderStateMixin{
  late TabController _tabController1;
  int _selectedIndex1 = 2;


  @override
  void initState() {
    super.initState();
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
      else if (_tabController1.index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InputPrompt()));
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text(
        //     'TRAILER',
        //     style: TextStyle(
        //       fontSize: 22,
        //       fontWeight: FontWeight.w700,
        //       color: Colors.white,
        //     ),
        //   ),
        //   centerTitle: true,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: [
        //           Color(0xFF9a7eff), // Left side color
        //           Color(0xFFbe82f4), // Right side color, change to desired color
        //         ],
        //       ),
        //     ),
        //   ),// Adds a shadow below the AppBar
        // ),
          // bottomNavigationBar: SizedBox(
          //   height: 70,
          //   child: TabBar(controller: _tabController1, tabs: const <Widget>[
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
        body: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('회원정보',
            style: TextStyle(
              fontFamily:"Pretendard" ,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('이메일',
              style: TextStyle(
                fontFamily:"Pretendard" ,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
              Text('abc@abc.com',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily:"Pretendard" ,
                ),),
            ],),
              SizedBox(height: 20,),
              Text('비밀번호 변경',
              style: TextStyle(
                fontSize: 25,
                fontFamily:"Pretendard" ,

                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              Text('로그아웃',
              style: TextStyle(
                fontSize: 25,
                fontFamily:"Pretendard" ,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 100,),
              Text('회원탈퇴',
              style: TextStyle(
                fontSize: 25,
                fontFamily:"Pretendard" ,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),),
          ],),
        )
      ),
    );
  }
}
