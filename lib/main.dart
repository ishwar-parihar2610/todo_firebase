import 'package:flutter/material.dart';
import 'package:todo_firebase/auth/auth_screens.dart';
import 'package:todo_firebase/screens/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
      theme:ThemeData(brightness:Brightness.dark,
      primaryColor:Colors.purple)

      
    );
  }
}
