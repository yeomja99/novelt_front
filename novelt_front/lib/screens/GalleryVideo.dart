import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/services/ApiService.dart';

import 'ShowGalleryVideo.dart';
import 'GalleryImage.dart';
import 'InputPrompt.dart';
import 'package:http/http.dart' as http;


class GalleryVideo extends StatefulWidget {
  final bool isCreateShortform; // 이 변수를 추가합니다.
  GalleryVideo({Key? key, this.isCreateShortform = false}) : super(key: key); // 기본값을 false로 설정

  @override
  _GalleryVideoState createState() => _GalleryVideoState();
}
class NovelThumnail {
  final int novelId;
  final String title;
  final String imageUrl;

  NovelThumnail({required this.novelId, required this.title, required this.imageUrl});

  factory NovelThumnail.fromJson(Map<String, dynamic> json) {
    return NovelThumnail(
      novelId: json['novel_id'] as int,
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}

class _GalleryVideoState extends State<GalleryVideo> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  int _selectedIndex1 = 0;
  int _selectedIndex2 = 1;
  List<NovelThumnail> thumnails = []; // 작품 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _fetchthumnail();
  }
  Future<NovelThumnail?> _fetchthumnail() async {
    print("_fetchthumnail");
    const String apiUrl = baseUrl + 'video_gallery/'; // 백엔드 API 엔드포인트 URL로 변경
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      print(apiUrl);
      print("response data: ${response.body}");

      if (response.statusCode == 200) {
        var decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> jsonResponse = json.decode(decodedResponse);
        print("response data: ${jsonResponse}");
        List<NovelThumnail> loadedNovelThumnails = jsonResponse.map((item) =>
            NovelThumnail.fromJson(item)).toList();

        setState(() {
          thumnails = loadedNovelThumnails;
          print("thumnails: ${thumnails}");

        });
      }else {
        print('Failed to load artworks');
      }
    } catch (e) {
      print('Error: $e');
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClickShorts(novelid: thumnails[index].novelId)));
                  },
                  child: Image.network(
                    baseUrl + thumnails[index].imageUrl,
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
