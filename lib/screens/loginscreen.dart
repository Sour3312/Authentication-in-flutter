// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:auth/auth.dart';
import 'package:authenicate_flutter/screens/forget.dart';
import 'package:authenicate_flutter/screens/signupscreen.dart';
import 'package:authenicate_flutter/users/user-main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginMail = "";
  var loginPassword = "";

  USerLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginMail, password: loginPassword);
      Fluttertoast.showToast(msg: "Logged in sucessfully");

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserMain(),
          ));
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Email not registered");
      }
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password entered by you");
      }
      print(e);
    }
    print("User Logged in");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _passwo = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            TextFormField(
              controller: _passwo,
              decoration: InputDecoration(
                label: Text("Password"),
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  loginMail = _email.text;
                  loginPassword = _passwo.text;
                });
                USerLogin();
              },
              child: Text("Login"),
            ),
            Row(
              children: [
                Text("Don't have account     "),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Text(" Signup"),
                ),
              ],
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgetScreen()));
                },
                child: Text("Forget Password"))
          ],
        ),
      ),
    );
  }
}
