// ignore_for_file: prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/loginscreen.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _newpassword = TextEditingController();

  var changedPassword = "";
  final _formkey = GlobalKey<FormState>();

  final curRentUser = FirebaseAuth.instance.currentUser;
  ChangeUSerPassword() async {
    print(_newpassword.text);
    try {
      if (_newpassword.text != Null) {
        await curRentUser!.updatePassword(changedPassword);
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        Fluttertoast.showToast(msg: "Password Changed sucessfully");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Please enter your new password first or ( $e )");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Form(
        key: _formkey,
        child: ListView(
          children: [
            TextFormField(
              controller: _newpassword,
              decoration: InputDecoration(
                label: Text("Enter new password"),
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  changedPassword = _newpassword.text;
                });
                ChangeUSerPassword();
                // print("Your new Password is : $changedPassword");
                // Fluttertoast.showToast(msg: "Password changed sucessfully");
              },
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
