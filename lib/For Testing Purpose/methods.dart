import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_city_project/For%20Testing%20Purpose/chatroom.dart';
import 'package:safe_city_project/Mobile%20Screens/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Options Screens/Chat.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Account Created Successfully");
      user.updateProfile(displayName: name);
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        "name": name,
        "email": email,
        "status": "Unavailable",
        'uid': _auth.currentUser?.uid
      });
      return user;
    } else {
      print("Account Creation Failed");
      return user;
    }
  } catch (e) {
    print("Account Creation Error: $e");
    if (e is FirebaseAuthException) {
      print("FirebaseAuthException code: ${e.code}");
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "User already exists with this email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfulyy");
      return user;
    } else {
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
  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const loginpage(usernameController: "")));
    });
  } catch (e) {
    print(e);
    return null;
  }
}

Widget contact(
    String urlImage, String title, var time, onOff, String msgs, context) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
    child: ListTile(
      onTap: () async {
        FirebaseFirestore _firestore = FirebaseFirestore.instance;

        // Fetch user data for the tapped contact
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('name',
                isEqualTo: title) // Use the appropriate field for name
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userMap =
              querySnapshot.docs[0].data() as Map<String, dynamic>;

          String roomId = chatRoomId(
            _auth.currentUser!.displayName.toString(),
            userMap['name'].toString(),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  chatroom(chatRoomID: roomId, userMap: userMap),
            ),
          );
        }
      },
      leading: Container(
        height: 50,
        width: 50,
        child: ClipOval(
          child: Image.asset(
            urlImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Row(
        children: [
          // const Icon(
          //   Icons.done_all,
          //   size: 20,
          //   color: Colors.blueAccent,
          // ),
          // const SizedBox(
          //   width: 4.0,
          // ),
          Text(
            msgs,
          ),
        ],
      ),
      trailing: Text(time),
    ),
  );
}

String chatRoomId(String user1, String user2) {
  if (user1.toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
    return "$user1$user2";
  } else {
    return "$user2$user1";
  }
}

Future<List<Map<String, dynamic>>> fetchContacts() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  QuerySnapshot snapshot = await _firestore
      .collection('chatroom')
      .where('chatRoomId', arrayContains: _auth.currentUser?.displayName)
      .get();

  List<Map<String, dynamic>> results = [];

  for (var doc in snapshot.docs) {
    var userMap = doc.data() as Map<String, dynamic>;
    results.add(userMap);
  }

  return results;
}
