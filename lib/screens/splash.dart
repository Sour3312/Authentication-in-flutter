// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:authenicate_flutter/screens/signupscreen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 117),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignupScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.crop_outlined,
              size: 110,
            ),
            Text(
              "     Authentication In Flutter      ",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 70),
            RaisedButton(
              hoverColor: Colors.yellow,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SignupScreen())));
              },
              child: Text("Start"),
            )
          ],
        ));
  }
}
