// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, deprecated_member_use, avoid_print, use_build_context_synchronously

import 'package:auth/auth.dart';
import 'package:authenicate_flutter/screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var EMAIL = "";
  var PASSWORD = "";
  var CONFIRMPASSWORD = "";

  final _formkey = GlobalKey<FormState>();

  //+++++++++++++ Signup User code start +++++++++++++
  RegisterUser() async {
    if (PASSWORD == CONFIRMPASSWORD) {
      try {
        UserCredential _usercred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: EMAIL, password: PASSWORD);
        print("Usercredentials from Signupscreen :$_usercred");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Signup Sucessfully. You can now log in here")));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      } on FirebaseException catch (e) {
        //codes are written on firebase already
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "Password is too weak");
        }
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "Email already registered");
        }
        print(e);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Make sure PAssword and ConfirmPassword must be same");
    }
  }
  //+++++++++++++ End +++++++++++++

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _passwo = TextEditingController();
    TextEditingController _cnfpassw = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  label: Text("Email"),
                ),
              ),
              TextFormField(
                controller: _passwo,
                decoration: InputDecoration(
                  label: Text("Password"),
                ),
              ),
              TextFormField(
                controller: _cnfpassw,
                decoration: InputDecoration(
                  label: Text("Confirm Password"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      EMAIL = _email.text;
                      PASSWORD = _passwo.text;
                      CONFIRMPASSWORD = _cnfpassw.text;
                    });
                  }

                  print("User email enterd: $EMAIL");
                  print("User Password enterd: $PASSWORD");
                  print("User CnfPasswrd enterd: $CONFIRMPASSWORD");
                  RegisterUser();
                },
                child: Text("Signup"),
              ),
              Row(
                children: [
                  Text("Already have an account      "),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("LOgin"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}
