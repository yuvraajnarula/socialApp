import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

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
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.0),
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
                        Text('Register')
                      ),
                      SizedBox(
                        width: 60.0,
                      ),
                  ElevatedButton(
                      onPressed: () {

                      },
                      child: Text('Login'),
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
                      btnTextColor: Colors.grey,
                      btnColor: Colors.white,
                      width: 240,
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
