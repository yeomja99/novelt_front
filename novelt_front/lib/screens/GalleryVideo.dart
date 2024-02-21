import 'dart:convert';

import 'package:flutter/material.dart';

import 'ShowGalleryVideo.dart';
import 'GalleryImage.dart';
import 'InputPrompt.dart';
import 'package:http/http.dart' as http;

// 데이터 모델
class thumbnail {
  final String title;
  final String imageUrl;

  thumbnail({required this.title, required this.imageUrl});
}

class GalleryVideo extends StatefulWidget {
  @override
  _GalleryVideoState createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  int _selectedIndex1 = 0;
  int _selectedIndex2 = 1;
  List<thumbnail> thumnails = []; // 작품 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _fetchthumnail();
  }

  Future<void> _fetchthumnail() async {
    const String apiUrl = 'https://your-backend-api.com/artworks'; // 백엔드 API URL 변경 필요
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          thumnails = data.map((item) => thumbnail(
            title: item[0],
            imageUrl: item[1],
          )).toList();
        });
      } else {
        print('Failed to load artworks.');
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 두 열로 설정
                childAspectRatio: (9 / 16), // 16:9 비율의 세로 이미지
              ),
              itemCount: thumnails.length, // 'data'는 이미지 리스트를 나타냄
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // 여기에서 ClickShorts 페이지로 네비게이션 합니다.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClickShorts(title: thumnails[index].title)));
                  },
                  child: Image.network(
                    thumnails[index].imageUrl,
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
