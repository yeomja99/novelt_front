import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double loadingProgress = 0.27; // Example loading progress value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Spinning indicator at the top
            SizedBox(height: 20), // Spacing between the indicator and the text
            Text(
              '생성 중... (${(loadingProgress * 100).toInt()}%)', // Loading text with percentage
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20), // Spacing between the text and the progress bar
            SizedBox(
              width: 200, // 원하는 너비로 설정하세요.
              child: LinearProgressIndicator(
                value: loadingProgress, // 현재 진행 상태 값
                backgroundColor: Colors.black26, // 채워지지 않은 부분의 배경색
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9a7eff)), // 진행 표시줄 색상
                minHeight: 5, // 진행 표시줄의 높이
              ),
            )

          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoadingScreen()));
