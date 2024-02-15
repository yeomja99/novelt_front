import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPW extends StatefulWidget {
  SignUpPW({super.key});

  @override
  State<SignUpPW> createState() => _SignUpPWState();

  final pwController = TextEditingController();

}

class _SignUpPWState extends State<SignUpPW> {
  final pwController = TextEditingController();

  bool _isCheck = false;
  bool showpw(bool _isCheck){
    if (_isCheck){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 100)),
            ),
            Text('비밀번호를 입력해주세요 :)',
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
                    controller: pwController,
                    obscureText: showpw(_isCheck),
                    decoration: const InputDecoration(
                      hintText: '8자 이상 입력해주세요',
                      hintStyle: TextStyle(
                        fontSize: 22,
                      )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                Checkbox(
                  value: _isCheck,
                  onChanged: (value) {
                    setState(() {
                      _isCheck = value!;
                      });
                    },
                  ),
                  Text('비밀번호 보기')
                ],
              ),
            ),

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
                child: const Text('회원가입 완료하기')),

        ]),
      ),
    );
  }
}