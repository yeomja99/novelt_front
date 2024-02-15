import 'package:flutter/material.dart';

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
    _tabController1 = TabController(length: 3, vsync: this);
    _tabController1.addListener(
            () => setState(() => _selectedIndex1 = _tabController1.index)
    );
    _tabController2 = TabController(length: 2, vsync: this, initialIndex: 1); // 여기에서 initialIndex를 추가합니다.
    _tabController2.addListener(() => setState(() => _selectedIndex2 = _tabController2.index));
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();
    super.dispose();
  }

  List data = [AssetImage('images/1.png'),AssetImage('images/5.png'),AssetImage('images/9.png')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
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
        ),// Adds a shadow below the AppBar
      ),

      bottomNavigationBar: SizedBox(
        height: 70,
        child: TabBar(controller: _tabController1, tabs: const <Widget>[
          Tab(
            icon: Icon(
              Icons.grid_on,
              color: Colors.black,
              size:28,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add_circle,
              color: Colors.deepPurpleAccent,
              size: 42,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: 32,
            ),
          )
        ]),
      ),
      body: Column(
        children: <Widget>[
          // ToggleButtons with each icon centered in its half of the screen
          TabBar(
            controller: _tabController2,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.video_collection_outlined)),
            ],
          ),


          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 두 열로 설정
                childAspectRatio: (9 / 16), // 16:9 비율의 세로 이미지
              ),
              itemCount: data.length, // 'data'는 이미지 리스트를 나타냄
              itemBuilder: (context, index) {
                return Image(
                  image: data[index], // data 리스트에서 AssetImage 객체를 직접 사용
                  fit: BoxFit.cover,
                );
              },
            ),

          ),
        ],
      ),
    );
  }
}
