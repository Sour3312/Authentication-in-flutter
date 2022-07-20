// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _DashboardState();
}

class _DashboardState extends State<Profile> {
  final creationt = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  User? usser = FirebaseAuth.instance.currentUser;
  VerifyEmail() async {
    // if (usser != null && !usser!.emailVerified) {
    await usser!.sendEmailVerification();
    Fluttertoast.showToast(msg: " verification Email sent");
    // }
    // else {
    //   Fluttertoast.showToast(msg: "Alredy Verified");
    // }
  }

  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _usermail = FirebaseAuth.instance.currentUser!.email;
  final _currentStatus =
      FirebaseAuth.instance.currentUser!.metadata.creationTime;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User id : $_uid"),
          SizedBox(
            height: 20,
          ),
          Text("Email is : $_usermail"),
          usser!.emailVerified
              ? Text(
                  "verified",
                  style: TextStyle(color: Colors.blueGrey),
                )
              : TextButton(
                  onPressed: () {
                    VerifyEmail();
                  },
                  child: Text("Verify Email")),
          SizedBox(
            height: 20,
          ),
          Text("Created on : $_currentStatus")
        ],
      ),
    );
  }
}
