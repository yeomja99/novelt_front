import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGeneration.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';

class ShowImages extends StatefulWidget {
  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _selectedIndex = 0;
  final double imgwidth = 112;
  final double imgheight = 200;
  final List<String> images = ['testimg.png','testimg.png','testimg.png','testimg.png'];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "CREATE TRAILER",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: TabBar(controller: _tabController, tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ]),
        ),
        body: Container(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text('장면 설명',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text('gpt 내용 입력',
                style: TextStyle(
                    fontSize: 18
                ),),),
            SizedBox(
              height: 10,
            ),
            Expanded(child: ImagesGridPageView()),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        ),
      ),
    );
  }
}

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