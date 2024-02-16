import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPrompt extends StatefulWidget {
  InputPrompt({super.key});

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> with TickerProviderStateMixin {
  late TabController _tabController1;
  int _selectedIndex1 = 1;

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 3, vsync: this, initialIndex: 1); // 여기에서 initialIndex를 추가합니다.
    _tabController1.addListener(() => setState(() => _selectedIndex1 = _tabController1.index));
  }


  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  var genrelist = ['현대판 로맨스', '로맨스 판타지', '현대판 소설','판타지 소설','무협'];
  String? _selectValue = '현대판 로맨스';
  var lightpurple = 0xFFD9C2EF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F7FF),
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
        bottomNavigationBar: SizedBox(
          height: 70,
          child: TabBar(controller: _tabController1, tabs: const <Widget>[
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
        body: Column(
          children: <Widget>[
          // ToggleButtons with each icon centered in its half of the screen

        ],
      ),
    );
  }
}