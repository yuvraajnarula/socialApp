import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Registration',style: TextStyle(
                  fontSize: 36.0,
                ),),
                SizedBox(
                  height: 20.0
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Fullname'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                  obscureText: true,
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
                      'value' : 'Male',
                    },
                    {
                      'display': 'Female',
                      'value' : 'Female',
                    },
                    {
                      'display': 'Non binary',
                      'value' : 'Non binary',
                    },
                    {
                      'display': 'Not to say',
                      'value':'Not to say',
                    }
                  ],
                  textField: 'display',
                  valueField: 'value',

            ),
                SizedBox(
                  height:80.0,
                ),
                ElevatedButton(
                    onPressed: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Text('Register'),
                        Icon(Icons.chevron_right_sharp),
                      ],
                    ),
                ),
            ],
          ),
          ),
        ),
    );
  }
}
