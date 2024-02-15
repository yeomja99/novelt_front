import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpName extends StatelessWidget {
  SignUpName({super.key});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 100)),
            ),
            Text('이름을 입력해주세요 :)',
            style:TextStyle(
              fontSize: 30,
                fontWeight: FontWeight.w900,
                color:Color(0xFF000000),)
              ),
            Padding(
              padding:  const EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: Column(
                children:[
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: '예: 김노벨',
                      hintStyle: TextStyle(
                        fontSize: 22,
                      )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
                onPressed: (){},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(340, 55),
                  backgroundColor: Color(0xFF000000),
                  foregroundColor: Color(0xFFFFFFFF),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                child: const Text('계속하기')),

        ]),
      ),
    );
  }
}