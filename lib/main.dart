// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:authenicate_flutter/screens/signupscreen.dart';
import 'package:authenicate_flutter/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirstScreen());
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print("Some error Occured");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return MaterialApp(
            home: Material(
              child: Scaffold(body: MyHomePage()),
            ),
          );
        }));
  }
}
