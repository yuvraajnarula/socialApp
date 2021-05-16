import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = "Login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                  ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  fillColor: Colors.white,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Don't have an account Sign Up here"),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: (){

              },
                  child: Text('Login')
              )
            ],
          ),
        ),
      )
    );
  }
}
