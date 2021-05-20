import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final _auth = FirebaseAuth.instance;

class _ProfilePageState extends State<ProfilePage> {
  final _database = FirebaseFirestore.instance;
  final currentUser = _auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: _database
                    .collection('users')
                    .doc(currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator();
                  }
                  var document = snapshot.data;
                  return Column(
                    children: [Text(document['fullName'])],
                  );
                },
              )
            ],
          ),
        ));
  }
}
