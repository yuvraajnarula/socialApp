import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_app/screens/feed.dart';
import 'package:social_app/screens/gregister.dart';
import 'package:social_app/screens/login.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  Future<bool> docExists(User user) async {
    await _database
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        print('Doc Exists');
        return true;
      } else {
        print('Doc Doesnt Exist');
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            final _user = _auth.currentUser;
            if (docExists(_user) == true) {
              print('Doc Exists');
              return FeedPage();
            } else {
              print('Doc Doesnt Exist');
              return GoogleRegister();
            }
          }
        }
        return Scaffold(
          body: SpinKitChasingDots(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
