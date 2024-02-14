import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpEmail extends StatelessWidget {
  SignUpEmail({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 100)),
            ),
            Text('이메일을 입력해주세요 :)',
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
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: '예: abc@abc.com',
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