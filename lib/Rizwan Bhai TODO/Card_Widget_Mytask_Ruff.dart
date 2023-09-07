import 'package:flutter/material.dart';


class Card_Widget_Mytask_Ruff extends StatelessWidget {
  const Card_Widget_Mytask_Ruff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                
              }, child: Text('Green'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              ),
              
              ElevatedButton(onPressed: () {
                
              }, child: Text('Red'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              ),
              ElevatedButton(onPressed: () {
                
              }, child: Text('Blue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}