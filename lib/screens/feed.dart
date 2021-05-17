import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
