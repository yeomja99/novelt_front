import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveandGeneration extends StatelessWidget {
  SaveandGeneration({super.key});

  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('CREATE TRAILER',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle:true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Icon(Icons.check_circle_rounded,
                    size:100),
                    SizedBox(height: 10,),
                    Text('이미지 생성 완료!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 50
                      ,),
                    ElevatedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(340, 55),
                          backgroundColor: Color(0xFFE460EF),
                          foregroundColor: Color(0xFFFFFFFF),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        child: const Text('이미지 저장하기')),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(340, 55),
                          backgroundColor: Color(0xFF9156CA),
                          foregroundColor: Color(0xFFFFFFFF),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        child: const Text('쇼츠 생성하러 가기')),
                    SizedBox(height: 5,),

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}