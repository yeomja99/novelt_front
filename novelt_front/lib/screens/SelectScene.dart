import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/screens/SaveandGenerationImages.dart';
import 'package:novelt_front/services/ApiService.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Edit.dart';
import 'package:http/http.dart' as http;
import 'package:novelt_front/models/novel_data.dart';


class SelectScene extends StatefulWidget {
  final SelectNovelData novelData; // 타입을 NovelData로 변경

  SelectScene({Key? key, required this.novelData}) : super(key: key);

  @override
  State<SelectScene> createState() => _SelectSceneState();

}

class PageState {
  bool isSaved;
  String selectedImageUrl;
  String editsubtitle;

  PageState({this.isSaved = false, this.selectedImageUrl = '', this.editsubtitle=""});
}

class _SelectSceneState extends State<SelectScene> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPageIndex = 0;
  bool _isSaveCompleted = false;
  String _updatedImageUrl = '';
  List<PageState> _pageStates = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageStates = List.generate(widget.novelData.novelData.length, (_) => PageState());

  }
  @override
  void dispose() {
    _pageController.dispose(); // 컨트롤러 해제
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final pages = widget.novelData.novelData; // 각 장면에 대한 데이터

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
        ), // Adds
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text(
            '마음에 드는 이미지를 선택하세요!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 30,),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length + 1, // 여기서 pages는 장면 데이터 배열입니다.
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                // 마지막 페이지인지 확인
                if (index == pages.length) {
                  // 마지막 페이지일 경우 "이미지 수정 마치기" 버튼 표시
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SaveandGenerationImages(novelId: widget.novelData.novelId,)),
                        );
                        // 버튼 클릭 시 실행할 로직, 예: Navigator.pop(context) 또는 상태 업데이트
                        print("이미지 수정 완료!");
                      },
                      child: Text("이미지 수정 마치기"),
                    ),
                  );
                } else {
                  // 마지막 페이지가 아닐 경우 기존 로직 실행 (이미지 표시)
                  var page = pages[index]; // 현재 페이지(장면)의 데이터를 가져옵니다.
                  final pageState = _pageStates[index];
                  print("yyyyyy${_pageStates[index].isSaved}");
                  if (pageState.isSaved){
                    return Center(
                      child: Column(
                        children: [
                          Container(child: Column(
                            children: [
                              Text(
                                '장면 번호: ${index + 1}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '장면 설명: ${page.subtitle}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                            ,),

                        Expanded(
                          child: Image.network(
                            _pageStates[index].selectedImageUrl.startsWith('http')
                                ?_pageStates[index].selectedImageUrl
                            : baseUrl+_pageStates[index].selectedImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                      ),
                    );
                  }else {
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '장면 번호: ${index + 1}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '장면 설명: ${page.subtitle}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 한 줄에 표시할 이미지 수
                                childAspectRatio: 1, // 이미지의 가로 세로 비율
                              ),
                              // itemCount: page.imageUrls.length,
                              itemCount: 4,
                              itemBuilder: (context, imgIndex) {
                                return GestureDetector(
                                  onTap:  () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Edit(
                                              imgindex: imgIndex,
                                              sceneNumber: page.sceneNumber,
                                              sceneSubtitle: page.subtitle,
                                              imageUrl: page
                                                  .imageUrls[imgIndex],
                                              novelId: widget.novelData.novelId,
                                            ),
                                      ),
                                    );
                                    print("result: ${result.containsKey('isSaved')}");
                                    if (result != null && result is Map) {
                                      setState(() {
                                        _pageStates[index].isSaved = result['isSaved'];
                                        _pageStates[index].selectedImageUrl = result['imageUrl'];
                                        page.subtitle = result['editSubtitle'];
                                       print("durl: ${_pageStates[index].isSaved}");
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.network(
                                        page.imageUrls[imgIndex].startsWith(
                                            'http')
                                            ? page.imageUrls[imgIndex]
                                            : baseUrl +
                                            page.imageUrls[imgIndex],
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: _pageController, // PageView 컨트롤러 연결
              count: pages.length, // 총 페이지(장면) 수
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                type: WormType.thinUnderground,
              ), // 인디케이터 디자인
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//       body: SingleChildScrollView( // Added SingleChildScrollView
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 20, top: 10),
//               child: Text(
//                 '장면 설명',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//
//             SizedBox(
//               height: 5,
//             ),
//
//             SizedBox(
//               height: 430,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: pages.length,
//                 onPageChanged: (int index) {
//                   setState(() {
//                     _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   // return pages[index % pages.length];
//                   if (_isSaveCompleted && _updatedImageUrl.isNotEmpty){
//                     // return Image.network(_updatedImageUrl, fit:BoxFit.contain);
//                     return Image.asset('images/1.png', fit:BoxFit.contain);
//                   } else{
//                     return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Text('장면 번호: ${pages[index].sceneNumber}'),
//                             Text('장면 설명: ${pages[index].subtitle}'),
//                             GridView.builder(
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: (1 / 1.6),
//                               ),
//                               itemCount: pages[index].imageUrls.length,
//                               itemBuilder: (context, imgIndex) {
//                                 return GestureDetector(
//                                   onTap: (){
//                                     Navigator.push(context,
//                                       MaterialPageRoute(
//                                         builder: (context) => Edit(
//                                             sceneNumber: pages[index].sceneNumber,
//                                             sceneSubtitle: pages[index].subtitle,
//                                             imageUrl: pages[index].imageUrls[imgIndex],
//                                             novelId: widget.novelData.novelId
//                                         ),
//                                       ),
//                                     ).then((result) {
//                                       if (result != null && result['isSaved'] == true) {
//                                         // 저장 작업이 성공적으로 완료되었다는 정보를 처리
//                                         setState(() {
//                                           _isSaveCompleted = true; // 저장 여부를 true로 업데이트
//                                           _updatedImageUrl = result['imageUrl']; // 수정된 imageUrl을 상태에 저장
//                                         });
//                                       } else {
//                                         // 저장하지 않았을 때의 로직 (옵션)
//                                         setState(() {
//                                           _isSaveCompleted = false;
//                                         });
//                                       }
//                                     });
//                                   },
//                                   // child: Image.network(_pages[index].imageUrls[imgIndex]), // 이미지 표시
//                                   child: Image.asset(_updatedImageUrl), // 이미지 표시
//                                 ) ;
//                               },
//                               shrinkWrap: true, // 내부 GridView 스크롤 문제 해결
//                               physics: NeverScrollableScrollPhysics(), // 내부 GridView 스크롤 비활성화
//                             ),
//                           ],
//                         )
//                     );
//                   };
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),            if (_currentPageIndex != pages.length - 1)
//               Center(
//                 child: SmoothPageIndicator(
//                   controller: _pageController,
//                   count: pages.length,
//                   effect: const WormEffect(
//                     dotHeight: 10,
//                     dotWidth: 10,
//                     type: WormType.thinUnderground,
//                   ),
//                 ),
//               ),
//
//             if (_currentPageIndex == pages.length - 1) // 마지막 페이지인 경우 버튼 표시
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context, MaterialPageRoute(builder: (_) => SaveandGenerationImages())
//                     );
//                   },
//                   child: Text('이미지 수정 마치기'),
//                 ),
//               ),
//
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




  // @override
  // Widget build(BuildContext context) {
  //   // 이제 widget.novelData는 NovelData 타입이므로, pageDatas에 직접 접근 가능
  //   final pages = widget.novelData.novelData;
//
//     return Scaffold(
//       appBar: AppBar(
//         // AppBar 구성
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // 페이지 뷰 구성
//             Container(
//               height: 200, // 높이는 적절하게 조정
//               child: PageView.builder(
//                 itemCount: pages.length,
//                 onPageChanged: (int index) {
//                   setState(() {
//                     _currentPageIndex = index;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final page = pages[index];
//                   return Column(
//                     children: [
//                       Text(page.subtitle), // 장면 설명 표시
//                       Expanded(
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: page.imageUrls.length,
//                           itemBuilder: (context, imgIndex) {
//                             return Image.asset(page.imageUrls[imgIndex]); // 이미지 표시
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             // 기타 UI 구성 요소...
//           ],
//         ),
//       ),
//     );
//   }
// }

// 원본
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'TRAILER',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [
//                 Color(0xFF9a7eff), // Left side color
//                 Color(0xFFbe82f4), // Right side color, change to desired color
//               ],
//             ),
//           ),
//         ),// Adds a shadow below the AppBar
//       ),
//       backgroundColor: Colors.white,
//
//       body: SingleChildScrollView( // Added SingleChildScrollView
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 20, top: 10),
//               child: Text(
//                 '장면 설명',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//
//             SizedBox(
//               height: 5,
//             ),
//
//             SizedBox(
//               height: 430,
//               child: PageView.builder(
//                 controller: _controller,
//                 itemCount: _pages.length,
//                 onPageChanged: (int index) {
//                   setState(() {
//                     _currentPageIndex = index; // 현재 페이지 인덱스 업데이트
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   // return pages[index % pages.length];
//                   if (_isSaveCompleted && _updatedImageUrl.isNotEmpty){
//                     // return Image.network(_updatedImageUrl, fit:BoxFit.contain);
//                     return Image.asset('images/1.png', fit:BoxFit.contain);
//                   } else{
//                   return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text('장면 번호: ${_pages[index].sceneNumber}'),
//                           Text('장면 설명: ${_pages[index].subtitle}'),
//                           GridView.builder(
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               childAspectRatio: (1 / 1.6),
//                             ),
//                             itemCount: _pages[index].imageUrls.length,
//                             itemBuilder: (context, imgIndex) {
//                               return GestureDetector(
//                                 onTap: (){
//                                   _sendImageDataToBackend(imgIndex, _novelId, _pages[index].sceneNumber);
//                                   Navigator.push(context,
//                                       MaterialPageRoute(
//                                           builder: (context) => Edit(
//                                             selectedImageIndex: imgIndex,
//                                             sceneNumber: _pages[index].sceneNumber,
//                                             sceneSubtitle: _pages[index].subtitle,
//                                             imageUrl: _pages[index].imageUrls[imgIndex],
//                                             novelId: _novelId
//                                           ),
//                                       ),
//                                     ).then((result) {
//                                     if (result != null && result['isSaved'] == true) {
//                                       // 저장 작업이 성공적으로 완료되었다는 정보를 처리
//                                       setState(() {
//                                         _isSaveCompleted = true; // 저장 여부를 true로 업데이트
//                                         _updatedImageUrl = result['imageUrl']; // 수정된 imageUrl을 상태에 저장
//                                       });
//                                     } else {
//                                       // 저장하지 않았을 때의 로직 (옵션)
//                                       setState(() {
//                                         _isSaveCompleted = false;
//                                       });
//                                     }
//                                     });
//                                 },
//                                 // child: Image.network(_pages[index].imageUrls[imgIndex]), // 이미지 표시
//                                 child: Image.asset('images/1.png'), // 이미지 표시
//                               ) ;
//                             },
//                             shrinkWrap: true, // 내부 GridView 스크롤 문제 해결
//                             physics: NeverScrollableScrollPhysics(), // 내부 GridView 스크롤 비활성화
//                           ),
//                         ],
//                       )
//                   );
//                   };
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),            if (_currentPageIndex != _pages.length - 1)
//             Center(
//               child: SmoothPageIndicator(
//                 controller: _controller,
//                 count: _pages.length,
//                 effect: const WormEffect(
//                   dotHeight: 10,
//                   dotWidth: 10,
//                   type: WormType.thinUnderground,
//                 ),
//               ),
//             ),
//
//             if (_currentPageIndex == _pages.length - 1) // 마지막 페이지인 경우 버튼 표시
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
//
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

