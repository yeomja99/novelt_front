import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/MyPage.dart';
import 'package:novelt_front/services/ApiService.dart';

import 'GalleryVideo.dart';
import 'ShowGalleryImages.dart';
import 'package:http/http.dart' as http;

class GalleryImage extends StatefulWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  _GalleryImageState createState() => _GalleryImageState();
}
class NovelImage {
  final int novelId;
  final String novelTitle;
  final List<String> imageUrls;

  NovelImage({required this.novelId, required this.novelTitle, required this.imageUrls});

  factory NovelImage.fromJson(Map<String, dynamic> json) {
    return NovelImage(
      novelId: json['novel_id'] as int,
      novelTitle: json['title'],
      imageUrls: List<String>.from(json['image_url']),
    );
  }
}

class CardImage {
  final String topLeft;
  final String topRight;
  final String bottomLeft;
  final String bottomRight;
  final String title;

  CardImage({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.title,
  });
}


class _GalleryImageState extends State<GalleryImage> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  int _selectedIndex = 0;
  List<NovelImage> novelImages = []; // 소설 정보를 저장할 리스트
  List<CardImage> cardImages = [];

  @override
  void initState() {
    super.initState();
    _fetchArtWorks();
  }

  Future<CardImage?> _fetchArtWorks() async {
    print("_fetchArtWorks");
    const String apiUrl = baseUrl + 'image_gallery/'; // 백엔드 API 엔드포인트 URL로 변경
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> jsonResponse = json.decode(decodedResponse);
        print("response data: ${jsonResponse}");

        List<NovelImage> loadedNovelImages = jsonResponse.map((item) =>
            NovelImage.fromJson(item)).toList();

        setState(() {
          novelImages = loadedNovelImages;
          // NovelImage 리스트를 기반으로 CardImage 리스트를 생성합니다.
          cardImages = novelImages.map((novelImage) {
            // 이미지 URL이 4개 미만일 경우를 대비하여 처리
            List<String> images = novelImage.imageUrls + List.filled(
                4 - novelImage.imageUrls.length, novelImage.imageUrls.first);
            return CardImage(
              title: novelImage.novelTitle,
              topLeft: images[0],
              topRight: images.length > 1 ? images[1] : images[0],
              bottomLeft: images.length > 2 ? images[2] : images[0],
              bottomRight: images.length > 3 ? images[3] : images[0],
            );
          }).toList();
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
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //2열 형태
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: cardImages.length,
              itemBuilder: (BuildContext context, int index) {
                final card = cardImages[index];
                return Container( // Wrap the card in GestureDetector
                //     onTap: () {
                //   // Navigate to ShowGalleryImages when the card is tapped
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ShowGalleryImages(title: card.title, novelId: novelImages[index].novelId)), // Pass the selected card data to the ShowGalleryImages page
                //   );
                // },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 1, // 정사각형 카드
                      child: GestureDetector(
                        onTap: () {
                          // 여기서 탭 이벤트 처리를 합니다. 예를 들어, DetailPage로 이동
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowGalleryImages(title: card.title, novelid: novelImages[index].novelId), // DetailPage는 구현해야 할 새로운 페이지입니다.
                          ));
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8, // 그림자 효과를 위한 elevation 값 추가
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: Image.network(baseUrl+card.topLeft, fit: BoxFit.cover)),
                                    Expanded(child: Image.network(baseUrl+card.topRight, fit: BoxFit.cover)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: Image.network(baseUrl+card.bottomLeft, fit: BoxFit.cover)),
                                    Expanded(child: Image.network(baseUrl+card.bottomRight, fit: BoxFit.cover)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity, // This ensures the container takes all available width
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 10.0),// This aligns the child to the left of the container
                        child: Text(
                          card.title,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left, // This ensures the text inside the Text widget is left-aligned
                        ),
                      ),
                    ),

                  ],
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
