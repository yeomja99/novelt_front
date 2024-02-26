import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:novelt_front/services/ApiService.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Edit.dart';

class ImagesGridPageView extends StatefulWidget {
  final String title;
  final int novelid;

  const ImagesGridPageView({Key? key, required this.title, required this.novelid}) : super(key: key);
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
    fetchImages().then((urls) {
      print(urls);
      setState(() {
        imageUrls = urls; // 비동기적으로 받아온 이미지 URL 목록을 상태 변수에 할당
      });
    }).catchError((error) {
      // 오류 처리 (예: 사용자에게 메시지 표시)
      print("이미지를 불러오는데 실패했습니다: $error");
    });
  }

  // 백엔드로부터 이미지 정보를 받아오는 함수
  Future<List<String>> fetchImages() async {
    // 백엔드 API URL, 실제 URL로 변경해야 합니다.
    var url = Uri.parse(baseUrl + 'image_gallery/'+widget.novelid.toString());
    // HTTP POST 요청을 보내고, novel id를 JSON 본문으로 전송합니다.
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // 응답에서 이미지 URL 목록을 추출합니다.
      var data = jsonDecode(response.body);
      if (data['image_path'] is List) {
        // 안전하게 List<dynamic>을 List<String>으로 변환
        List<String> imageUrls = List<String>.from(data['image_path'].map((item) => item.toString()));
        print("imageUrls: $imageUrls");
        return imageUrls;
      } else {
        throw Exception('image_path is not a list');
      }
    } else {
      throw Exception('Failed to load images');
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
                baseUrl+imageUrls[index],
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
  final int novelid;
  ShowGalleryImages({Key? key, required this.title, required this.novelid,}) : super(key: key);
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
          Expanded(child: ImagesGridPageView(title: widget.title, novelid: widget.novelid,)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
