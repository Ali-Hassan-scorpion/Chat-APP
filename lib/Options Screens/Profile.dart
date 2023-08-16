import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/For%20Testing%20Purpose/methods.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Map<String, dynamic> userMap;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(54, 94, 212, 1.0),
              Color.fromRGBO(78, 88, 155, 1.0),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.transparent,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              _auth.currentUser!.displayName.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              _auth.currentUser!.email.toString(),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                logOut(context);
                await _firestore
                    .collection('users')
                    .doc(_auth.currentUser?.uid)
                    .update({'status': 'Offline'});
              },
              icon: Icon(Icons.logout),
              label: Text('Logout', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(54, 94, 212, 1.0),
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
