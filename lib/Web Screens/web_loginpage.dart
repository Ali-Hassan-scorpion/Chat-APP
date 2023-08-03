import 'package:flutter/material.dart';

class web_loginpage extends StatefulWidget {
  const web_loginpage({super.key});

  @override
  State<web_loginpage> createState() => _web_loginpageState();
}

class _web_loginpageState extends State<web_loginpage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Text("Web Login Page"),
        ],
      ),
    );
  }
}
