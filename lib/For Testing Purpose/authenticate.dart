import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/Mobile%20Screens/UserDashboard.dart';
import 'package:safe_city_project/Mobile%20Screens/loginpage.dart';

class authenticate extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser!=null)
      {
        return UserDashboard();
      }
    else
      return loginpage();
  }
}
