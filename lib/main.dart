import 'package:flutter/material.dart';
import 'package:social_app/screens/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Social App',
      routes:{
        LoginPage.id: (context) => LoginPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}