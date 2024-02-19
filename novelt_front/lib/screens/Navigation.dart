import 'package:flutter/material.dart';
import 'package:novelt_front/screens/AppController.dart';
import 'package:novelt_front/screens/MyPage.dart';
import 'package:novelt_front/screens/GalleryPage.dart';
import 'package:novelt_front/screens/InputPrompt.dart';



class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  final int initialIndex;

  NavigationPage({this.initialIndex = 0});
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    GalleryPage(),
    InputPrompt(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: ValueListenableBuilder<int>(
        valueListenable: AppController().selectedIndexNotifier,
        builder: (context, selectedIndex, child){
          return IndexedStack(
            index: selectedIndex,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.grid_on, color: Colors.black, size:28), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: Colors.deepPurpleAccent, size:42), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black, size:32), label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          AppController().setSelectedIndex(index);
        },
        showSelectedLabels: false, // 선택된 레이블을 숨깁니다.
        showUnselectedLabels: false, // 선택되지 않은 레이블을 숨깁니다.

      ),
    );
  }
}
