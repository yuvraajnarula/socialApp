import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();
  String email;
  String pass;
  bool passHidden = true;
  bool loading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          toolbarHeight: 80.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          backgroundColor: HexColor('#8e9aaf'),
        ),
        backgroundColor: HexColor("#feeafa"),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 // Text(
                   // 'Login',
                   // style: TextStyle(
                     // fontSize: 36.0,
                    //),
                  //),
                  SizedBox(
                    height: 80.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      suffixIcon: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.mail),
                      ),

                    ),
                    onSaved: (val) {
                      email = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Email cant be empty';
                      }
                      if (!EmailValidator.validate(val)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passHidden = !passHidden;
                              });
                            },
                            icon: Icon(passHidden
                                ? Icons.visibility_off
                                : Icons.visibility))),
                    onSaved: (val) {
                      pass = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (val.length < 6) {
                        return 'Password cannot be less than 6 characters';
                      } else {
                        return null;
                      }
                    },
                    obscureText: passHidden,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // TODO: Change this to button
                  Row(
                    children: [
                      SizedBox(
                        width: 30.0
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child:
                        Text('Register'),
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#cbc0d3'),
                          shadowColor: Colors.grey,

                        ),

                      ),

                      SizedBox(
                        width: 60.0,
                      ),
                  ElevatedButton(
                      onPressed: () {

                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#cbc0d3'),
                        shadowColor: Colors.grey,

                    ),
                  ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SignInButton(
                      buttonType: ButtonType.google,
                      imagePosition: ImagePosition.right,
                      //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                      buttonSize: ButtonSize.large,
                      btnTextColor: HexColor('#cbc0d3'),
                      btnColor: Colors.white,
                      width: 200,
                      //[width] Use if you change the text value.
                      btnText: 'Login using Google',
                      onPressed: () {
                        print('click');
                      })

                ],
              ),
            ),
          ),
        ));
  }
}
