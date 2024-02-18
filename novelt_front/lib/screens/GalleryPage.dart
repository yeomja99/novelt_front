import 'package:flutter/material.dart';
import 'GalleryImage.dart';
import 'GalleryVideo.dart';
import 'ShowGalleryImages.dart';
import 'ShowGalleryVideo.dart';


class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar의 높이를 조절하기 위한 PreferredSize
    final PreferredSizeWidget appBarBottom = PreferredSize(
      preferredSize: Size.fromHeight(0.0), // TabBar의 높이 조절
      child: Align(
        alignment: Alignment.center,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.grid_on),), // 이미지 탭
            Tab(icon: Icon(Icons.video_collection_outlined), ), // 비디오 탭
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottom,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GalleryImage(), // 이미지 갤러리 위젯
          GalleryVideo(), // 비디오 갤러리 위젯
        ],
      ),
    );
  }
}
