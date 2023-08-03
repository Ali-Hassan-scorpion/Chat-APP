import 'package:flutter/material.dart';
import 'package:safe_city_project/Web%20Screens/web_loginpage.dart';
import 'package:safe_city_project/Mobile%20Screens/loginpage.dart';
import 'package:safe_city_project/responsiveLayout.dart';
class main_2 extends StatelessWidget {
  const main_2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBox Safe City',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home:  responsiveLayout(
        mobileScreenLayout: loginpage(usernameController: ""),
        webScreenLayout: web_loginpage(),
      ),
    );
  }
}
