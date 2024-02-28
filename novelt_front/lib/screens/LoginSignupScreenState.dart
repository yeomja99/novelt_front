import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:novelt_front/services/ApiService.dart';
import 'Navigation.dart';


class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  // 자동 로그인 여부
  bool switchValue = false;

  // 로그인 아이디와 비밀번호 정보
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _login() async {
    print("login");
    print(userIdController.text.runtimeType);
    print(passwordController.text.runtimeType);
    final response = await http.post(
      Uri.parse(baseUrl  + 'login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': userIdController.text,
        'pw': passwordController.text,
      })
    );
    // print( userIdController.text.runtimeType);
    // print( passwordController.text.runtimeType);
    print("response ${response.body}");
    // print("responsecode ${response.statusCode}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] == 'Login successful') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
        print("Login successful");
      }
    } else {
      // 로그인 실패 처리
      print("Login failed");
    }
  }

  // 회원가입 유저 네임, 이메일, 비밀번호 정보
  final TextEditingController SignUpuserNameController = TextEditingController();
  final TextEditingController SignUpuserIdController = TextEditingController();
  final TextEditingController SignUppasswordController = TextEditingController();
  Future<void> _signup() async {
    final response = await http.post(
      Uri.parse(baseUrl + 'signup/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': SignUpuserNameController.text,
        'password': SignUpuserIdController.text,
        'userid': SignUpuserIdController.text
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        // 회원가입 성공 처리
        isSignupScreen = false;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
        print("Signup successful");
      }
    } else {
      // 회원가입 실패 처리
      print("Signup failed");
    }
  }
  bool isSignupScreen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 157),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),

                  ],
                ),
              ),
            ),
          ),
          //배경
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 180,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              padding: EdgeInsets.all(20.0),
              height: isSignupScreen ? 280.0 : 250.0,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignupScreen
                                      ? Color(0xFF9156CA)
                                      : Color(0xFFC398ED)),
                            ),
                            if (!isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.purple,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'SIGNUP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Color(0xFF9156CA)
                                      : Color(0xFFC398ED)),
                            ),
                            if (isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.purple,
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                  if(isSignupScreen)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: SignUpuserNameController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Color(0xFF737379),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'User name',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Color(0xFF737379)),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: SignUpuserIdController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xFF737379),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Color(0xFF737379)),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: SignUppasswordController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xFF737379),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Color(0xFF737379)),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(!isSignupScreen)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: userIdController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xFF737379),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC398ED)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC398ED)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Color(0xFF737379)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xFF737379),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFFC398ED)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Color(0xFF737379)),
                                  contentPadding: EdgeInsets.all(10)),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // 텍스트 폼 필드
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: isSignupScreen ? 430 : 390,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    // 여기에서 ClickShorts 페이지로 네비게이션 합니다.
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
                    if (isSignupScreen){
                      _signup();
                    }
                    else{
                      _login();
                    }
                  },
                  child: Container(
                    // 여기에서 페이지 이동 함수 구현
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.deepPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 전송버튼
          Positioned(
              top: MediaQuery.of(context).size.height - 145,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(155, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF3B5999),
                    ),
                    icon: Icon(Icons.add), // 실제로는 구글 아이콘을 사용해야 합니다.
                    label: Text('Google'),
                  ),
                  SizedBox(height: 8), // 버튼 사이의 간격
                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(155, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF2DB400), // Palette 클래스에 Naver 색상을 정의해야 합니다.
                    ),
                    icon: Icon(Icons.add), // 실제로는 네이버 아이콘을 사용해야 합니다.
                    label: Text('Naver'),
                  ),

                ],
              )

          ),
        ],
      ),
    );
  }
}