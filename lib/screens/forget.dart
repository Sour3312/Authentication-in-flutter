// ignore_for_file: prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';

import 'loginscreen.dart';

class ForgetScreen extends StatefulWidget {
  ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formkey = GlobalKey<FormState>();
  var femail = "";

  ResetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: femail);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Reset link has been send to your registered mail id")));
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "USer not Found");
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _resetmail = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Forget PAssword Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _resetmail,
                decoration: InputDecoration(
                  label: Text("Email"),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    femail = _resetmail.text;
                  });
                  ResetPassword();
                  print("Reset mail is: $femail");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Get Reset Link"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
