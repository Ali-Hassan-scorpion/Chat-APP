import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_city_project/Mobile%20Screens/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Account Created Successfully");
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        "name":name,
        "email":email,
        "status":"Unavailable"
      });
      return user;
    } else {
      print("Account Creation Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if(user != null)
      {
        print("Login Successfulyy");
        return user;
      }
    else
      {
        print("Login Failed");
        return user;
      }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try{
    await _auth.signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const loginpage(usernameController: "")));
    });
  }
  catch(e){
    print(e);
    return null;
  }
}
