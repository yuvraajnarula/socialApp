import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  static String id = "Login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                  ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
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
              Column(
               children: [
                 ElevatedButton(
                   onPressed:() {

                 },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Login'),
                       Icon( Icons.lock),
                     ],
                   )
                 ),
                  SizedBox(
                    width: 25.0,
                  ),

                 SignInButton(
                   Buttons.Google,
                   text: "Sign up with Google",
                   onPressed: () {},
                 )
               ],
              )
            ],
          ),
        ),
      )
    );
  }
}
