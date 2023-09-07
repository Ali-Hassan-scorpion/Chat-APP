import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:safe_city_project/Options%20Screens/Chat.dart'; // Import the ChatScreen
import 'package:safe_city_project/Options%20Screens/Profile.dart';
import 'package:safe_city_project/Rizwan%20Bhai%20TODO/check.dart';
import '../Options Screens/Todo.dart';
import 'SignUp.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> itemImages = [
    "chatLogo.png",
    "todoLogo.png",
    "profileLogo.png",
    "optionalLogo.png",
  ];

  List<String> itemText = [
    "Chat",
    "ToDo",
    "Profile",
    "Add Users",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                  Text(
                    'Islamabad Police',
                    style: TextStyle(
                        color: Color.fromRGBO(54, 94, 212, 1.0),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "Main Menu",
                style: TextStyle(
                    color: Color.fromRGBO(54, 94, 212, 1.0), fontSize: 18, letterSpacing: 2),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: SizedBox(
                  // Wrap the GridView with a SizedBox to set a fixed size
                  height: 350,
                  width: 350, // Set the desired height for the GridView
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.0, // Set a fixed aspect ratio for square cards
                      mainAxisSpacing: 30,
                    ),
                    itemCount: itemImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (itemText[index] == "Chat") {
                            Get.to(()=>ChatScreen());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => ChatScreen(),
                            //   ),
                            // );
                          } else if (itemText[index] == "ToDo") {
                            Get.to(()=>MyApp2());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => Todo(),
                            //   ),
                            // );
                          } else if (itemText[index] == "Profile") {
                            Get.to(()=>Profile());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => Profile(),
                            //   ),
                            // );
                          } else if (itemText[index] == "Add Users") {
                            if(_auth.currentUser?.uid=='f52WXwSpvUecogG9olRQucxbS9B3')
                              {Get.to(()=>signup());}
                            else
                              {Get.snackbar("Alert", "Only For Admins");}
                            
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => Add Users(),
                            //   ),
                            // );
                          } else {
                            throw Error();
                          }
                        },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 92, // Set a fixed height for the image container
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/${itemImages[index]}"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Center(
                                  child: Text(
                                    itemText[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(54, 94, 212, 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Powered By Safe City',
              style: TextStyle(
                color: Color.fromRGBO(54, 94, 212, 1.0),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
