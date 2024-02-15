
import 'package:flutter/material.dart';
import 'package:novelt_front/screens/InputPrompt.dart';
import 'package:novelt_front/screens/SignUpEmail.dart';
import 'package:novelt_front/screens/SignUpName.dart';
import 'package:novelt_front/screens/SignUpPW.dart';

import 'screens/SignIn.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: InputPrompt(),
    );
  }
}
