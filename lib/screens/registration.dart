import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/loaders/registration.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _key = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
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
              title: Text('Register'),
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
                      //Text(
                      // 'Registration',
                      //  style: TextStyle(
                      //    fontSize: 36.0,
                      //   ),
                      // ),
                      SizedBox(height: 7.50),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Fullname',
                          helperText: 'eg: John Doe',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.perm_contact_cal_rounded),
                          ),
                          helperStyle: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
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
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email ',
                            helperText: 'eg: johndoe@gmail.com',
                            helperStyle: TextStyle(
                              fontSize: 8.0,
                            ),
                            suffixIcon: Icon(Icons.mail)),
                        onSaved: (val) {
                          email = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Innvalid Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password ",
                            helperText: '6-12 character strength',
                            helperStyle: TextStyle(
                              fontSize: 8.0,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passHidden = !passHidden;
                                  });
                                },
                                icon: Icon(passHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        validator: (val) {
                          if (val.isEmpty || val.length < 6) {
                            return 'Password must be 6 characters long';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          pass = val;
                        },
                        obscureText: passHidden,
                        keyboardType: TextInputType.visiblePassword,
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
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DropDownFormField(
                        titleText: 'Your Gender',
                        hintText: 'Gender',
                        dataSource: [
                          {
                            'display': 'Male',
                            'value': 'Male',
                          },
                          {
                            'display': 'Female',
                            'value': 'Female',
                          },
                          {
                            'display': 'Non binary',
                            'value': 'Non binary',
                          },
                          {
                            'display': 'Not to say',
                            'value': 'Not to say',
                          }
                        ],
                        textField: 'display',
                        valueField: 'value',
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
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: pass);
                              Navigator.pushReplacementNamed(context, '/feed');
                            } catch (e) {
                              print(e.toString());
                              return 'Some Error Occurred';
                            }
                            setState(() {
                              loading = false;
                            });
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
