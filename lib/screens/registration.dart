import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
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
                        'Registration',
                        style: TextStyle(
                          fontSize: 36.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Fullname'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Username'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'email'),
                        validator: (val) {
                          if (val.isEmpty || !EmailValidator.validate(val)) {
                            return 'Invalid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
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
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Age',
                        ),
                      ),
                      DropDownFormField(
                        titleText: 'Gender',
                        hintText: 'Please choose one',
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
                        height: 80.0,
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
                              } catch (e) {
                                print(e.toString());
                                return 'Some Error Occured';
                              }
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: Text('Register')),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
