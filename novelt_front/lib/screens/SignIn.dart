import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 50)),
            ),
            Center(
              child: Image(
                image: AssetImage('images/logo.png'),
                width: 170,
                height: 190,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
              child: Column(
                children: [
                  TextField(
                    controller: idController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.redAccent),
                        ),
                        labelText: '아이디',
                      )
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: pwController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      labelText: '비밀번호',
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(340, 55),
                        backgroundColor: Color(0xFF9156CA),
                        foregroundColor: Color(0xFFFFFFFF),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      child: const Text('로그인')),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(340, 55),
                        backgroundColor: Color(0xFF9156CA),
                        foregroundColor: Color(0xFFFFFFFF),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      child: const Text('회원가입')),
                  SizedBox(height: 5,),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    child: Text('아이디 / 비밀번호 찾기',
                      style: TextStyle(
                        fontSize: 15,
                      ),),)

                ],
              ),
            ),

          ],
        
        ),
      ),
    );
  }
}