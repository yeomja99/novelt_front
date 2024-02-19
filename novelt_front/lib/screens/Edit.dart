import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novelt_front/screens/SelectScene.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 장면 번호랑 자막

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final editController = TextEditingController();
  String edittext = "";

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(
            () => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      bottomNavigationBar: SizedBox(
        height: 70,
        child: TabBar(controller: _tabController, tabs: const <Widget>[
          Tab(
            icon: Icon(
              Icons.grid_on,
              color: Colors.black,
              size:28,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add_circle,
              color: Colors.deepPurpleAccent,
              size: 42,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: 32,
            ),
          )
        ]),
      ),
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
            child: Text('gpt 내용 입력',
              style: TextStyle(
                fontSize: 18,
              ),),),
          SizedBox(
            height: 15,
          ),
          Image.asset('images/testimg.png',
            width: 270,
            height: 300,
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: 80,
              child: Center(
                child: TextField( onChanged: (text) {
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
                  onPressed: (){},
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
                  onPressed: (){
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

