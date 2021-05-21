import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/loaders/registration.dart';

class GoogleRegister extends StatefulWidget {
  @override
  _GoogleRegisterState createState() => _GoogleRegisterState();
}

final _auth = FirebaseAuth.instance;
final _database = FirebaseFirestore.instance;

class _GoogleRegisterState extends State<GoogleRegister> {
  final _user = _auth.currentUser;
  String fullName, userName, email, age, gender;
  bool loading = false;
  bool passHidden = false;
  final _key = GlobalKey<FormState>();
  final _users = _database.collection('users');
  @override
  Widget build(BuildContext context) {
    return loading
        ? RegisterLoading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Registration'),
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
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 7.50),
                      TextFormField(
                        initialValue: _user.displayName,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Fullname',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.perm_contact_cal_rounded),
                          ),
                          helperStyle: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
                        onSaved: (val) {
                          fullName = val;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username ',
                          helperText: 'eg: john12',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.perm_identity),
                          ),
                          helperStyle: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
                        onSaved: (val) {
                          userName = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You must enter a username';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: _user.email,
                        decoration: InputDecoration(
                            hintText: 'Email ',
                            helperStyle: TextStyle(
                              fontSize: 8.0,
                            ),
                            suffixIcon: Icon(Icons.mail)),
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Age',
                          helperText: 'Above 13 years',
                          helperStyle: TextStyle(
                            fontSize: 8.0,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.cake_sharp),
                          ),
                        ),
                        onSaved: (val) {
                          age = val;
                        },
                        validator: (val) {
                          if (val.isEmpty || int.parse(val) < 13) {
                            return 'You must be 13 years of age';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // DropDownFormField(
                      //   titleText: 'Your Gender',
                      //   hintText: 'Gender',
                      //   dataSource: [
                      //     {
                      //       'display': 'Male',
                      //       'value': 'Male',
                      //     },
                      //     {
                      //       'display': 'Female',
                      //       'value': 'Female',
                      //     },
                      //     {
                      //       'display': 'Non binary',
                      //       'value': 'Non binary',
                      //     },
                      //     {
                      //       'display': 'Not to say',
                      //       'value': 'Not to say',
                      //     }
                      //   ],
                      //   textField: 'display',
                      //   valueField: 'value',
                      //   onSaved: (val) {
                      //     gender = val;
                      //   },
                      //   validator: (val) {
                      //     if (val.isEmpty) {
                      //       return 'Gender cannot be empty';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      TextFormField(
                        onSaved: (val) {
                          gender = val;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          _key.currentState.save();
                          if (_key.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            try {
                              _users.doc(_user.uid).set({
                                "fullName": fullName,
                                "userName": userName,
                                "email": email,
                                'provider': 'Google',
                                "gender": gender,
                                "age": age
                              }).then((value) => print('User Added'));
                              setState(() {
                                loading = false;
                              });
                              Navigator.pushReplacementNamed(context, '/feed');
                            } catch (e) {
                              print(e.toString());
                              return 'Some Error Occurred';
                            }
                          }
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#cbc0d3'),
                          shadowColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
