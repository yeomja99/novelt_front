import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPrompt extends StatefulWidget {
  InputPrompt({super.key});

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> {
  var genrelist = ['현대판 로맨스', '로맨스 판타지', '현대판 소설','판타지 소설','무협'];
  String? _selectValue = '현대판 로맨스';
  var lightpurple = 0xFFD9C2EF;

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
        child:Container(
          child:Column(
            children: [
              Padding(
                padding:  const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: (EdgeInsets.only(top: 20)),
                    ),
                    Text(
                      '제목',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(lightpurple)),
                          ),
                          labelText: '장르를 선택하세요.',
                        )
                    ),
                    SizedBox(height: 10),


                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: (EdgeInsets.only(top: 20)),
                    ),
                    Text(
                      '장르',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    DropdownButton<String>(
                        value: genrelist[0],
                        items: genrelist
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        )).toList(),
                        onChanged: (value){
                          setState((){
                            _selectValue = value;
                          });
                        }),

                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: (EdgeInsets.only(top: 20)),
                    ),
                    Text(
                      '줄거리',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(lightpurple)),
                          ),
                          labelText: '줄거리를 입력하세요.',
                        )
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: (EdgeInsets.only(top: 20)),
                    ),
                    Text(
                      '강조 포인트',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(lightpurple)),
                          ),
                          labelText: '강조 포인트를 입력하세요.',
                        )
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: (EdgeInsets.only(top: 20)),
                    ),
                    Text(
                      '등장인물',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(lightpurple), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Column(children: [
                      Text(
                        '이름',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Color(lightpurple)),
                            ),
                            labelText: '등장인물 이름을 입력하세요.',
                          )
                      ),
                      ]
                      ,)
                      ,)
                  ],
                ),
              )


            ],
          ),
        ),
      )
    );
  }
}