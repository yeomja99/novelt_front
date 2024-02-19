import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';

class SelectScene extends StatefulWidget {
  @override
  State<SelectScene> createState() => _SelectSceneState();
}

class _SelectSceneState extends State<SelectScene>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _selectedIndex = 1;
  final double imgwidth = 112;
  final double imgheight = 200;
  int _currentPageIndex = 0;


  final controller = PageController(
    viewportFraction: 0.8,
    keepPage: false,
    initialPage: 0,
  );

  final pages = List.generate(
    6,
        (index) => Container(
      margin: EdgeInsets.all(10),
      child: Builder( // Builder 위젯을 사용하여 context를 제공
        builder: (BuildContext context) {
          return Container(
            height: 400,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
                        );
                      },
                      child: Image.asset(
                        'images/testimg.png',
                        width: 120,
                        height: 205,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
                        );
                      },
                      child: Image.asset(
                        'images/testimg.png',
                        width: 120,
                        height: 205,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
                          );
                        },
                        child: Image.asset(
                          'images/testimg.png',
                          width: 120,
                          height: 205,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/testimg.png',
                      width: 120,
                      height: 205,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
  );

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

      body: SingleChildScrollView( // Added SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                '장면 설명',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'gpt 내용 입력',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            SizedBox(
              height: 430,
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
                  });
                },
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),            if (_currentPageIndex != pages.length - 1)
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  type: WormType.thinUnderground,
                ),
              ),
            ),

            if (_currentPageIndex == pages.length - 1) // 마지막 페이지인 경우 버튼 표시
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SaveandGenerationImages())
                );
              },
              child: Text('이미지 수정 마치기'),
            ),
          ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

