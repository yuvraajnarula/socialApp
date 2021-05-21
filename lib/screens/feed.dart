import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      backgroundColor: HexColor('#efd3d7'),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text('Profile Page'))
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color : HexColor('#feeafa'),
        backgroundColor: HexColor('#efd3d7'),
        items: <Widget>[
          Icon(Icons.home_outlined ,size: 15, color: Colors.black),
          Icon(Icons.add, size: 15, color: Colors.black),
          Icon(Icons.perm_identity, size: 15, color: Colors.black)
        ],
        animationDuration:Duration(
          milliseconds: 450,
        ),
        height: 50.0,
        animationCurve: Curves.easeInOut,
        onTap: (index){
          debugPrint('Current index is $index');

        },
        buttonBackgroundColor: HexColor('#feeafa'),

      ),

      
    );
  }
}
