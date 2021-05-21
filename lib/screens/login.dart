import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sign_button/sign_button.dart';
import 'package:social_app/loaders/registration.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();
  final _database = FirebaseFirestore.instance;
  String email;
  String pass;
  bool passHidden = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? RegisterLoading()
        : Scaffold(
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
                            onPressed: () {},
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
                          SizedBox(width: 30.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register');
                            },
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('#cbc0d3'),
                              shadowColor: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              _key.currentState.save();
                              if (_key.currentState.validate()) {
                                try {
                                  setState(() {
                                    loading = true;
                                  });
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: pass);
                                  setState(() {
                                    loading = false;
                                  });
                                } catch (e) {
                                  print(e.toString());
                                  return 'Some Error Occurred';
                                }
                              }
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
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            final GoogleSignInAccount googleUser =
                                await GoogleSignIn().signIn();
                            final GoogleSignInAuthentication googleAuth =
                                await googleUser.authentication;

                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken,
                            );
                            await _auth.signInWithCredential(credential);
                            final user = _auth.currentUser;
                            try {
                              await _database
                                  .collection('users')
                                  .doc(user.uid)
                                  .get()
                                  .then((DocumentSnapshot snap) {
                                if (snap.exists) {
                                  Navigator.pushReplacementNamed(
                                      context, '/feed');
                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/gregister');
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              });
                            } catch (e) {
                              print(e.toString());
                              return 'Some Error Occurred';
                            }
                            // Navigator.pushReplacementNamed(
                            //     context, '/gregister');
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
