import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
      Get.to(()=>loginpage());
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const loginpage()));
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
            _auth.currentUser!.uid.toString(),
            userMap['uid'].toString(),
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
      subtitle: Text(
        msgs,overflow: TextOverflow.ellipsis,softWrap: true,
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
class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when query is empty
    }

    return FutureBuilder(
      future: searchUsersByEmail(query),
      // Replace with your method to search users by email
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(54, 94, 212, 1.0),
              )); // Show a loading indicator while fetching results
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final searchResults = snapshot.data ?? [];

        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (BuildContext context, int index) {
            final result = searchResults[index];
            return contact(
              'assets/images/logo.png', // Replace with actual image path
              result['name'], // Assuming 'name' is the user's name
              result['status'], // Replace with the appropriate time
              result['status'], // Replace with the user's status
              result['email'], // Replace with the user's message
              context,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when query is empty
    }
    return FutureBuilder(
      future: getSuggestions(query),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(54, 94, 212, 1.0),
              )); // Show a loading indicator while fetching suggestions
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final suggestions = snapshot.data ?? [];

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            final suggestion = suggestions[index];
            return FutureBuilder(
              future: getUserData(suggestion),
              // Replace with your method to fetch user data
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(); // Return an empty widget while fetching user data
                }

                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }

                final userMap = userSnapshot.data ?? {};
                return contact(
                  'assets/images/logo.png', // Replace with actual image path
                  userMap['name'] ?? suggestion,
                  // Use the display name from user data, or the suggestion itself
                  userMap['status'],
                  // Replace with the appropriate time
                  userMap['status'], // Replace with the user's status
                  userMap['email'], // Replace with the user's message
                  context,
                );
              },
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> onSearch(String email) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0].data() as Map<String, dynamic>;
    }

    return {};
  }

  Future<List<String>> getSuggestions(String query) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .get();

    List<String> suggestions = [];
    for (var doc in snapshot.docs) {
      var email = doc['email'] as String;
      if (email.startsWith(query)) {
        suggestions.add(email);
      }
    }
    return suggestions;
  }

  Future<List<Map<String, dynamic>>> searchUsersByEmail(String query) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .get();

    List<Map<String, dynamic>> searchResults = [];
    for (var doc in snapshot.docs) {
      if (doc['email'].startsWith(query)) {
        var userMap = doc.data() as Map<String, dynamic>;
        searchResults.add(userMap);
      }
    }

    return searchResults;
  }

  Future<Map<String, dynamic>> getUserData(String suggestion) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: suggestion)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0].data() as Map<String, dynamic>;
    }

    return {};
  }
}
// Future<List<Map<String, dynamic>>> fetchContacts() async {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   QuerySnapshot snapshot = await _firestore
//       .collection('chatroom')
//       .where('chatRoomId', arrayContains: _auth.currentUser?.uid)
//       .get();
//
//   List<Map<String, dynamic>> results = [];
//
//   for (var doc in snapshot.docs) {
//     var userMap = doc.data() as Map<String, dynamic>;
//     results.add(userMap);
//   }
//
//   return results;
// }
