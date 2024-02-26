import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novelt_front/services/ApiService.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class ClickShorts extends StatefulWidget {
  final int novelid;
  ClickShorts({Key?key, required this.novelid}) : super(key:key);

  @override
  _ClickShortsState createState() => _ClickShortsState();
}

class _ClickShortsState extends State<ClickShorts> {
  late VideoPlayerController controller;
  double? aspectRatio;
  double progress = 0;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    fetchVideoUrl(); // 백엔드로부터 비디오 URL을 받아옵니다.
  }
  // 백엔드로부터 비디오 URL을 받아오는 함수
  void fetchVideoUrl() async {
    // 백엔드 API URL
    var url = Uri.parse(baseUrl + 'video_gallery/'+widget.novelid.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var videoUrl = data['video_url']; // 백엔드 응답에서 비디오 URL을 추출합니다.
        print("gg ${baseUrl + videoUrl}");
        // controller = VideoPlayerController.network(baseUrl + "videos/rich_makne.mp4")
        controller = VideoPlayerController.networkUrl(Uri.parse(baseUrl+videoUrl))
          ..initialize().then((_) {
            setState(() {});
          })..addListener(() {
            final error = controller.value.errorDescription;
            if (error != null) {
              print("Video player error: $error");
            }
          });
        controller.setPlaybackSpeed(1);
        played();

        controller.addListener(() async {
          int max = controller.value.duration.inSeconds;
          setState(() {
            aspectRatio = controller.value.aspectRatio;
            position = controller.value.position;
            progress = (position.inSeconds / max * 100).isNaN
                ? 0
                : position.inSeconds / max * 100;
          });
        });
      } else {
        // 오류 처리: 응답 상태 코드가 200이 아닐 때
        print('Failed to fetch video URL: ${response.statusCode}');
      }
    } catch (e) {
      // HTTP 요청 실패 또는 다른 예외 처리
      print('Exception caught while fetching video URL: $e');
    }
  }


  void played() => controller.play();

  void stoped() => controller.pause();

  void seekTo(int value) {
    int add = position.inSeconds + value;

    controller.seekTo(Duration(seconds: add < 0 ? 0 : add));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
      body: Stack(
        children: [
          if (aspectRatio != null) ...[
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    bottom:
                    MediaQuery.of(context).padding.top + kToolbarHeight),
                child: AspectRatio(
                    aspectRatio: aspectRatio!, child: VideoPlayer(controller)),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            seekTo(-10);
                          },
                          child: const SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.replay_10_rounded,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            if (controller.value.isPlaying) {
                              stoped();
                            } else {
                              played();
                            }
                          },
                          child: SizedBox(
                            width: 30,
                            child: Icon(
                              controller.value.isPlaying
                                  ? Icons.stop
                                  : Icons.play_arrow_rounded,
                              size: 32,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            seekTo(10);
                          },
                          child: const SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.forward_10_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                            width: 30,
                            child: Text(
                              controller.value.position.toString().substring(2, 7),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            )),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 6,
                              width: MediaQuery.of(context).size.width - 206,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color.fromRGBO(135, 135, 135, 1),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 6,
                              width: (MediaQuery.of(context).size.width - 206) *
                                  (progress / 100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color.fromRGBO(215, 215, 215, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 30,
                            child: Text(
                              controller.value.duration.toString().substring(2, 7),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            )),
                      ],
                    )],
                  )
              ),
            )
          ]
        ],
      ),
    );
  }
}
