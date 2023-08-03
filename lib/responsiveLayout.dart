import 'package:flutter/material.dart';

class responsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const responsiveLayout({super.key,required this.mobileScreenLayout,required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 900) {
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );;
  }
}
