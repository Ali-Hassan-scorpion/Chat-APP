import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/Mobile%20Screens/UserDashboard.dart';
import '../set_height_and_width.dart';
import 'SignUp.dart';
import 'package:get/get.dart';

class loginpage extends StatefulWidget {
  final String usernameController;

  const loginpage({Key? key, required this.usernameController})
      : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formfield = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool passToggle = true;
  bool loading = false;

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackBar = SnackBar(content: Text("User Not Found"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        const snackBar = SnackBar(content: Text("Wrong password"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getheight(context),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage("assets/images/whitebackground.png"),
        //   fit: BoxFit.cover,
        // )),
        child: SingleChildScrollView(
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  children: const [
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
                Container(
                  width: 350,
                  margin: EdgeInsets.only(
                      top: getheight(context) * 0.13,
                      left: getwidth(context) * 0.05,
                      right: getwidth(context) * 0.05),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is missing';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(54, 94, 212, 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(54, 94, 212, 1.0),
                              width: 2,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(54, 94, 212, 1.0),
                                width: 1)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color.fromRGBO(54, 94, 212, 1.0),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: 350,
                  margin: EdgeInsets.only(
                      left: getwidth(context) * 0.05,
                      right: getwidth(context) * 0.05),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is missing';
                      }
                    },
                    obscureText: passToggle,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Color.fromRGBO(54, 94, 212, 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(54, 94, 212, 1.0),
                            width: 2,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(54, 94, 212, 1.0),
                              width: 1)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromRGBO(54, 94, 212, 1.0),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off,
                          color: Color.fromRGBO(54, 94, 212, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passController.text,
                        context: context);
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserDashboard()));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(54, 94, 212, 1.0),
                    ),
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Login',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 94, 212, 1.0),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextButton(
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                              color: Color.fromRGBO(54, 94, 212, 1.0),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Get.snackbar('Alert', 'Only Admins');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             const signup()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (BuildContext) =>
                //                   const UserDashboard()));
                //     },
                //     child: Text("User Dashboard")),
              ],
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
