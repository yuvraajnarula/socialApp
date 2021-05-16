import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

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
                height: 40.0,
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
                    height: 20.0,
                  ),

                 SignInButton(
                     buttonType: ButtonType.google,
                     imagePosition: ImagePosition.right,
                     //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                     buttonSize: ButtonSize.large,
                     btnTextColor: Colors.grey,
                     btnColor: Colors.white,
                     width: 240,
                     //[width] Use if you change the text value.
                     btnText: 'Login using Google',
                     onPressed: () {
                       print('click');
                     })
               ],
              )
            ],
          ),
        ),
      )
    );
  }
}
