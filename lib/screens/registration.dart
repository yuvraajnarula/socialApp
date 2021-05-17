import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:social_app/loaders/registration.dart';
import 'package:hexcolor/hexcolor.dart';

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
                            onPressed: (){

                            },
                            icon: Icon(Icons.perm_contact_cal_rounded),
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
                            onPressed: (){

                            },
                            icon: Icon(Icons.perm_identity),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Email ',
                          helperText: 'eg: johndoe@gmail.com',suffixIcon: IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.mail),
                          ),),
                          validator: (val) {
                            if (val.isEmpty || !EmailValidator.validate(val)) {
                              return 'Invalid Email ';
                            } else {
                              return null;
                            }
                        },
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password ",
                            helperText: '6-12 character strength' ,
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
                          suffixIcon: IconButton(
                            onPressed: (){

                            },
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
                        height:20.0,
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
