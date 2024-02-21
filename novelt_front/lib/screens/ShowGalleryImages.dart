import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Edit.dart';

class ImagesGridPageView extends StatefulWidget {
  final String title;
  const ImagesGridPageView({Key? key, required this.title}) : super(key: key);
  @override
  _ImagesGridPageViewState createState() => _ImagesGridPageViewState();
}

class _ImagesGridPageViewState extends State<ImagesGridPageView> {
  final PageController controller = PageController();
  int _currentPageIndex = 0;
  List<String> imageUrls = []; // 이미지 URL 리스트
  @override
  void initState() {
    super.initState();
    fetchImages(); // 이미지 정보를 백엔드로부터 받아오기
  }

  // 백엔드로부터 이미지 정보를 받아오는 함수
  Future<void> fetchImages() async {
    // 백엔드 API URL (이 부분은 실제 URL로 변경해야 합니다)
    var url = Uri.parse('https://your-api-endpoint.com/images?title=${widget.title}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        imageUrls = List<String>.from(data.map((item) => item.toString()));
      });
    } else {
      print('Failed to fetch images');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: imageUrls.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
              });
            },
            itemBuilder: (_, index) {
              return Image.network(
                imageUrls[index],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        SizedBox(height: 30,),
        SmoothPageIndicator(
          controller: controller,
          count: imageUrls.length,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }
}

class ShowGalleryImages extends StatefulWidget {
  final String title;
  ShowGalleryImages({Key? key, required this.title}) : super(key: key);
  @override
  State<ShowGalleryImages> createState() => _ShowGalleryImagesState();
}

class _ShowGalleryImagesState extends State<ShowGalleryImages> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  List<String> images = []; // 이미지 URL 리스트

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(child: ImagesGridPageView(title: widget.title)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
