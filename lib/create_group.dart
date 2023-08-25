import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/set_height_and_width.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> allContacts = [];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    initContacts();
  }

  Future<void> initContacts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('users').get();
    setState(() {
      allContacts = querySnapshot.docs.map((doc) {
        return {
          ...doc.data(),
          'isSelected': false, // Add the isSelected field
        };
      }).toList();
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
            Text(
              "Add Participants",
              style: TextStyle(fontSize: 12),
            )
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
      body: Container(
        child: Column(children: [
          Container(
            height: getheight(context) * 0.1,
            width: getwidth(context),
          ),
          Expanded(
            child: Container(
              height: getheight(context) * 0.9,
              width: getwidth(context),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: allContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> listofcontacts = allContacts[index];
                    return GestureDetector(
                      child: ListTile(
                        leading: Image.asset('assets/images/logo.png'),
                        title: Text(listofcontacts['name']),
                        subtitle: Text(listofcontacts['email']),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(duration:Duration(milliseconds: 400),
                          child:listofcontacts['isSelected']
                              ? Icon(Icons.done)
                              : IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    toggleSelection(index); },
                                ),
                      ),
                        ),)
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
