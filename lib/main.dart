import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:safe_city_project/For%20Testing%20Purpose/authenticate.dart';
import 'package:safe_city_project/Mobile%20Screens/loginpage.dart';
import 'firebase_options.dart';
import 'set_height_and_width.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => authenticate())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: getwidth(context),
        height: getheight(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen2.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.only(bottom: 30.0),
        //      // alignment: Alignment.center,
        //       // margin: EdgeInsets.only(right: 100.0),
        //       width: 50,
        //       height: 50,
        //       decoration: BoxDecoration(
        //         image: const DecorationImage(
        //           image: AssetImage('assets/images/logo.png'),
        //         ),
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.only(bottom: 30.0),
        //       width: getwidth(context) * 0.55,
        //       height: getheight(context) * 0.07,
        //       child: const Center(
        //         child: Text(
        //           'Powered By Safe City',
        //           style: TextStyle(
        //               color: Colors.blueAccent,
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: getheight(context) * 0.04),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         width: 50,
      //         height: 50,
      //         decoration: BoxDecoration(
      //           image: const DecorationImage(
      //             image: AssetImage('assets/images/logo.png'),
      //           ),
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //       ),
      //       const SizedBox(width: 5),
      //       // Add some space between the logo and the text
      //       Text(
      //         'Powered By Safe City',
      //         style: TextStyle(
      //           color: Colors.blueAccent,
      //           fontSize: 14.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
