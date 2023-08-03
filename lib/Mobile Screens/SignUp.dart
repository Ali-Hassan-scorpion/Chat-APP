import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginpage.dart';
import '../set_height_and_width.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool loading = false;
  final List<String> personTypes = [
    'Internee',
    'Contractual',
    'Permanent',
    'Vendors'
  ];
  String selectedPersonType = 'Permanent'; // Default value
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: getheight(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formfield,
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  SizedBox(
                    height: 100,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Safe City',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      Text(
                        'Islambad',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 300,
                        // margin: EdgeInsets.only(
                        //     left: getheight(context) * 0.05,
                        //     right: getwidth(context) * 0.05),
                        child: TextFormField(
                          style: TextStyle(color: Colors.blueAccent),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is missing';
                            }
                          },
                          keyboardType: TextInputType.name,
                          controller: firstnameController,
                          decoration: InputDecoration(
                              labelText: "First Name",
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
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        // margin: EdgeInsets.only(
                        //     left: getwidth(context) * 0.05,right: getheight(context) * 0.05,
                        //     ),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is missing';
                            }
                          },
                          keyboardType: TextInputType.name,
                          controller: lastnameController,
                          decoration: InputDecoration(
                              labelText: "Last Name",
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
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is missing';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
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
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is missing';
                        }
                      },
                      obscureText: passToggle,
                      keyboardType: TextInputType.emailAddress,
                      controller: passController,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(
                            passToggle
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: DropdownButton<String>(
                      underline: null,
                      isExpanded: true,
                      value: selectedPersonType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPersonType = newValue!;
                        });
                      },
                      icon: Icon(
                        // <-- Icon to change the down arrow
                        Icons.arrow_drop_down,
                        color: Colors
                            .blueAccent, // <-- Change the color of the down icon
                      ),
                      items: personTypes.map((String personType) {
                        return DropdownMenuItem<String>(
                          enabled: true,
                          alignment: Alignment.center,
                          value: personType,
                          child: Text(
                            personType,
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is missing';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Belt Number",
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
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1)),
                          prefixIcon: Icon(
                            Icons.conveyor_belt,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Already have an account ?",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Container(
                        width: 55,
                        child: TextButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        loginpage(usernameController: '')));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: getheight(context) * 0.04),
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
            // Add some space between the logo and the text
            Text(
              'Powered By Safe City',
              style: TextStyle(
                color: Colors.blueAccent,
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
