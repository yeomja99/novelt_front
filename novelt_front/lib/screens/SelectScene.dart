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
          (index) =>
          Container(
              margin: EdgeInsets.all(10),
              child: Container(height: 400,
                child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      children: [
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        ),
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        )
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      children: [
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        ),
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        )
                      ],),
                  ],),)
            // child: Container(
            //   height: 280,
            //   child: Center(
            //       child: Text(
            //         "Page $index",
            //         style: TextStyle(color: Colors.black),
            //       )),
            // ),
          ));


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
      backgroundColor: Colors.white,
      // bottomNavigationBar: SizedBox(
      //   height: 70,
      //   child: TabBar(controller: _tabController, tabs: const <Widget>[
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
      body: SingleChildScrollView( // Added SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
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

// class ImagesGridPageView extends StatefulWidget {
//   @override
//   _ImagesGridPageViewState createState() => _ImagesGridPageViewState();
// }
// class _ImagesGridPageViewState extends State<ImagesGridPageView> {
//   final PageController controller = PageController();
//   int _currentPageIndex = 0;
//
//   List<Widget> generateGridTiles() {
//     return List.generate(4, (index) {
//       // 이미지 경로는 배열 또는 다른 방식으로 관리하면 더 좋습니다.
//       String imagePath = 'images/testimg.png';
//
//       return GestureDetector(
//         onTap: () {
//           // 여기서 context를 사용할 수 있습니다.
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => Edit(),
//           ));
//         },
//         child: Image.asset(
//           imagePath,
//           fit: BoxFit.cover,
//         ),
//       );
//     });
//   }
//
//   List<Widget> generatePages() {
//     return List.generate(6, (index) {
//       return GridView.count(
//         crossAxisCount: 2,
//         padding: EdgeInsets.all(10),
//         children: generateGridTiles(),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> pages = generatePages();
//     return Column(
//       children: [
//         Expanded(
//           child: PageView.builder(
//             controller: controller,
//             itemCount: pages.length,
//             onPageChanged: (int index) {
//               setState(() {
//                 _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
//               });
//             },
//             itemBuilder: (_, index) {
//               return pages[index];
//             },
//           ),
//         ),
//         if (_currentPageIndex != pages.length - 1) // 마지막 페이지가 아닌 경우에만 SmoothPageIndicator 표시
//           SmoothPageIndicator(
//             controller: controller,
//             count: pages.length,
//             effect: WormEffect(
//               dotHeight: 10,
//               dotWidth: 10,
//               type: WormType.thinUnderground,
//             ),
//           ),
//         if (_currentPageIndex == pages.length - 1) // 마지막 페이지인 경우 버튼 표시
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context, MaterialPageRoute(builder: (_) => SaveandGenerationImages())
//                 );
//               },
//               child: Text('이미지 수정 마치기'),
//             ),
//           ),
//       ],
//     );
//   }
// }
