import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';

class ImagesGridPageView extends StatefulWidget {
  @override
  _ImagesGridPageViewState createState() => _ImagesGridPageViewState();
}

class _ImagesGridPageViewState extends State<ImagesGridPageView> {
  final PageController controller = PageController();
  int _currentPageIndex = 0;


  List<Widget> generatePages() {
    String imagePath = 'images/testimg.png';
    return List.generate(6, (index) {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = generatePages();
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
              });
            },
            itemBuilder: (_, index) {
              return pages[index];
            },
          ),
        ),
        SizedBox(height: 30,),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
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
  @override
  State<ShowGalleryImages> createState() => _ShowGalleryImagesState();
}

class _ShowGalleryImagesState extends State<ShowGalleryImages> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final List<String> images = ['testimg.png', 'testimg.png', 'testimg.png', 'testimg.png'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          Expanded(child: ImagesGridPageView()),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
