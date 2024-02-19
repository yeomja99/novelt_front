import 'package:flutter/material.dart';

import 'ShowGalleryVideo.dart';
import 'GalleryImage.dart';
import 'InputPrompt.dart';

class GalleryVideo extends StatefulWidget {
  const GalleryVideo({Key? key}) : super(key: key);

  @override
  _GalleryVideoState createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  int _selectedIndex1 = 0;
  int _selectedIndex2 = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List data = [AssetImage('images/1.png'),AssetImage('images/5.png'),AssetImage('images/9.png')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
      // bottomNavigationBar: SizedBox(
      //   height: 70,
      //   child: TabBar(controller: _tabController1, tabs: const <Widget>[
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 두 열로 설정
                childAspectRatio: (9 / 16), // 16:9 비율의 세로 이미지
              ),
              itemCount: data.length, // 'data'는 이미지 리스트를 나타냄
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // 여기에서 ClickShorts 페이지로 네비게이션 합니다.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClickShorts()));
                  },
                  child: Image(
                    image: data[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

          ),
        ],
      ),
    );
  }
}
