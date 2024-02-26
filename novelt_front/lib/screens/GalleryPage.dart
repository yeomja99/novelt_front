import 'package:flutter/material.dart';
import 'AppController.dart';
import 'GalleryImage.dart';
import 'GalleryVideo.dart';
import 'ShowGalleryImages.dart';
import 'ShowGalleryVideo.dart';


class GalleryPage extends StatefulWidget {
  final int initialIndex;
  bool isCreateShortform;
  GalleryPage({Key? key, this.initialIndex = 0, this.isCreateShortform = false}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}


class _GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // AppController의 현재 값을 사용하여 TabController를 초기화
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: AppController().galleryTabIndex.value,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    // AppController의 리스너를 제거하는 코드가 필요하면 여기에 추가
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar 설정은 유지
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)), // 이미지 탭
                Tab(icon: Icon(Icons.video_collection_outlined)), // 비디오 탭
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GalleryImage(),
          GalleryVideo(),
        ],
      ),
    );
  }
}
