import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/screens/feed.dart';
import 'package:social_app/screens/login.dart';
import 'package:social_app/wrapper.dart';
import 'package:social_app/screens/registration.dart';
import 'package:social_app/screens/login.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Unable to initialize Firebase');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Social App',
              routes: {
                '/login': (context) => LoginPage(),
                '/feed': (context) => FeedPage(),
              },
              home: Wrapper(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}

