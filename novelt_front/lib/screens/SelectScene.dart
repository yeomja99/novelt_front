import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';
import 'package:http/http.dart' as http;

class ImageData {
  final String imageUrl;
  ImageData({required this.imageUrl});
}

class PageData {
  final String subtitle;
  final int scenenumber;
  final List<String> imageUrls;

  PageData({
    required this.subtitle,
    required this.scenenumber,
    required this.imageUrls,
  });

  // JSON 데이터로부터 PageData 객체를 생성하는 팩토리 메서드
  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      subtitle: json['subtitle'],
      scenenumber: json['scenenumber'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
}

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
  List<PageData> _pages = []; // 페이지별 이미지 데이터 리스트

  final _controller = PageController(
    viewportFraction: 0.8,
    keepPage: false,
    initialPage: 0,
  );

  // final pages = List.generate(
  //   6,
  //       (index) => Container(
  //     margin: EdgeInsets.all(10),
  //     child: Builder( // Builder 위젯을 사용하여 context를 제공
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 400,
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
  //                       );
  //                     },
  //                     child: Image.asset(
  //                       'images/testimg.png',
  //                       width: 120,
  //                       height: 205,
  //                     ),
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
  //                       );
  //                     },
  //                     child: Image.asset(
  //                       'images/testimg.png',
  //                       width: 120,
  //                       height: 205,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
  //                       );
  //                     },
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => Edit()), // context 사용 가능
  //                         );
  //                       },
  //                       child: Image.asset(
  //                         'images/testimg.png',
  //                         width: 120,
  //                         height: 205,
  //                       ),
  //                     ),
  //                   ),
  //                   Image.asset(
  //                     'images/testimg.png',
  //                     width: 120,
  //                     height: 205,
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   ),
  // );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<PageData> pages = await _fetchPageData();
    // 데이터 로드 후 UI 업데이트를 위해 상태 변경
    setState(() {
      _pages = pages;
    });
  }

  Future<List<PageData>> _fetchPageData() async {
    const String apiUrl = 'http://your-fastapi-server.com/pages'; // API URL 수정 필요
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<PageData> pages = data.map((item) => PageData.fromJson(item)).toList();
        return pages;
      } else {
        throw Exception('Failed to load page data');
      }
    } catch (e) {
      print(e);
      return []; // 에러 발생 시 빈 리스트 반환
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Widget _buildPageItem(List<ImageData> pageImages) {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: (1 / 1.6),
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //     ),
  //     itemCount: pageImages.length,
  //     itemBuilder: (context, index) {
  //       return Image.network(pageImages[index].imageUrl);
  //     },
  //     shrinkWrap: true,
  //   );
  // }

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

            SizedBox(
              height: 5,
            ),

            SizedBox(
              height: 430,
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
                  });
                },
                itemBuilder: (context, index) {
                  // return pages[index % pages.length];
                  return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('장면 번호: ${_pages[index].scenenumber}'),
                          Text('장면 설명: ${_pages[index].subtitle}'),
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (1 / 1.6),
                            ),
                            itemCount: _pages[index].imageUrls.length,
                            itemBuilder: (context, imgIndex) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => Edit(
                                            selectedImageIndex: imgIndex,
                                            sceneNumber: _pages[index].scenenumber,
                                            sceneSubtitle: _pages[index].subtitle,
                                            imageUrl: _pages[index].imageUrls[imgIndex], // 여기에서 imageUrl을 올바르게 전달합니다.
                                          ),
                                      ),
                                    );
                                },
                                child: Image.network(_pages[index].imageUrls[imgIndex]), // 이미지 표시
                              ) ;
                            },
                            shrinkWrap: true, // 내부 GridView 스크롤 문제 해결
                            physics: NeverScrollableScrollPhysics(), // 내부 GridView 스크롤 비활성화
                          ),
                        ],
                      )
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),            if (_currentPageIndex != _pages.length - 1)
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  type: WormType.thinUnderground,
                ),
              ),
            ),

            if (_currentPageIndex == _pages.length - 1) // 마지막 페이지인 경우 버튼 표시
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

