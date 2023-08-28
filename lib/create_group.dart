import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/set_height_and_width.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> allContacts = [];
  List<Map<String, dynamic>> selectedContacts = [];
  bool isSelected = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    initContacts();
  }

  Future<void> initContacts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('users').get();

    List<Map<String, dynamic>> contacts = [];

    for (var doc in querySnapshot.docs) {
      if (doc.id != _auth.currentUser!.uid) {
        contacts.add({
          ...doc.data(),
          'isSelected': false,
        });
      }
    }

    setState(() {
      allContacts = contacts;
    });
  }

  void toggleSelection(int index) {
    setState(() {
      allContacts[index]['isSelected'] = !allContacts[index]['isSelected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
            ),
            selectedContacts.length < 1
                ? Text(
                    "Add Participants",
                    style: TextStyle(fontSize: 12),
                  )
                : Text(
                    "${selectedContacts.length} out of ${allContacts.length}",
                    style: TextStyle(fontSize: 12))
          ],
        ),
        leading: BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(54, 94, 212, 1.0),
              Color.fromRGBO(78, 88, 155, 1.0),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: selectedContacts.length >= 1
            ? Container(
                child: Column(children: [
                  Container(
                    height: getheight(context) * 0.12,
                    width: getwidth(context),
                    child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedContacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: getheight(context) * 0.05,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 8),
                                  child: CircleAvatar(
                                    // child: Text(
                                    //     "${selectedContacts[index]["name"]}"),
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage("assets/images/logo.png"),
                                    radius: getheight(context) * 0.035,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 11),
                                  child: Text(
                                    "${selectedContacts[index]['name']}",
                                    style: TextStyle(fontSize: 10),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Container(
                      height: getheight(context) * 0.88,
                      width: getwidth(context),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: allContacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> listofcontacts =
                              allContacts[index];
                          return GestureDetector(
                            onTap: () {
                              toggleSelection(index); // Toggle selection on tap
                              if (listofcontacts['isSelected']) {
                                // Add the selected contact to the selectedContacts list
                                selectedContacts.add(listofcontacts);
                              } else {
                                // Remove the deselected contact from the selectedContacts list
                                selectedContacts.remove(listofcontacts);
                              }
                              print(selectedContacts);
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                // Scroll to the maximum extent
                                duration: Duration(milliseconds: 300),
                                // Set the duration of the animation
                                curve:
                                    Curves.easeInOut, // Set the animation curve
                              );
                            },
                            child: ListTile(
                              leading: Image.asset('assets/images/logo.png'),
                              title: Text(listofcontacts['name']),
                              subtitle: Text(listofcontacts['email']),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 400),
                                  child: listofcontacts['isSelected']
                                      ? Icon(
                                          Icons.done,
                                          color: Color.fromRGBO(
                                              67, 97, 238, 0.9490196078431372),
                                        )
                                      : Icon(
                                          Icons.add,
                                          color: Color.fromRGBO(
                                              67, 97, 238, 0.9490196078431372),
                                        ), // Don't use IconButton here
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ]),
              )
            : Container(
                height: getheight(context),
                width: getwidth(context),
                key: ValueKey<int>(0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: allContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> listofcontacts = allContacts[index];
                    return GestureDetector(
                      onTap: () {
                        toggleSelection(index); // Toggle selection on tap
                        if (listofcontacts['isSelected']) {
                          // Add the selected contact to the selectedContacts list
                          selectedContacts.add(listofcontacts);
                        } else {
                          // Remove the deselected contact from the selectedContacts list
                          selectedContacts.remove(listofcontacts);
                        }
                        print(selectedContacts);
                      },
                      child: ListTile(
                        leading: Image.asset('assets/images/logo.png'),
                        title: Text(listofcontacts['name']),
                        subtitle: Text(listofcontacts['email']),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: listofcontacts['isSelected']
                                ? Icon(
                                    Icons.done,
                                    color: Color.fromRGBO(54, 94, 212, 1.0),
                                  )
                                : Icon(
                                    Icons.add,
                                    color: Color.fromRGBO(54, 94, 212, 1.0),
                                  ), // Don't use IconButton here
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: selectedContacts.length >= 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddSubject(selectedContacts: selectedContacts)));
              },
              child: Icon(Icons.navigate_next),
              backgroundColor: Color.fromRGBO(54, 94, 212, 1.0),
            )
          : null,
    );
  }
}

class AddSubject extends StatefulWidget {
  const AddSubject(
      {super.key, required List<Map<String, dynamic>> selectedContacts});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
              ),
              Text(
                "Add Subject",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          leading: BackButton(),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(54, 94, 212, 1.0),
                Color.fromRGBO(78, 88, 155, 1.0),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: getheight(context) * 0.2,
              width: getwidth(context),
              child: Row(
                children: [
                  Text("Group Name:"),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Group Name",
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 1)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: getheight(context) * 0.8,
            )
          ],
        ));
  }
}
