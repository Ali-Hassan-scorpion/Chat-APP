
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Card_Widget_Mytask_Ruff.dart';
import 'Card_Widget_Ruff.dart';
import 'Form_List_Ruff.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AssignToMeTask_New(),debugShowCheckedModeBanner: false,);
  }
}


class AssignToMeTask_New extends StatefulWidget {
   const AssignToMeTask_New({super.key});

  @override
  State<AssignToMeTask_New> createState() => _AssignToMeTask_NewState();
}

class _AssignToMeTask_NewState extends State<AssignToMeTask_New> {
  GlobalKey _newKey = GlobalKey();
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Card_Widget_Mytask_Ruff(),
    Card_Widget_Ruff(),
    Form_List_Ruff(),
    // BottomAppBar(),
    // Card_Widget(),
    // Form_List(),
  ];

  void _onSelected(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blue.shade100,
          color: Colors.blue.shade200,
          animationDuration: const Duration(milliseconds: 500),
          key: _newKey,
          items: [
            Icon(Icons.home),
            Icon(Icons.favorite),
            Icon(Icons.settings),
          ],

          onTap: _onSelected,

          // onTap: (index){
          //   setState(() {
          //     if(index == 0){
          //       context.go('/');
          //     }
          //     else if(index == 1){
          //       context.go('/b');
          //     }
          //     else if(index == 2){
          //       context.go('/c');
          //     }
          //   });
          // }
        ),
      backgroundColor: Colors.blue.shade100,
      // appBar: AppBar(
      //   title: Text(
      //     'Ruff Assigned to Me',
      //   ),
      //   actions: const [
      //     CircleAvatar(
      //       backgroundImage: AssetImage('images/1.jpg'),
      //       radius: 20.0,
      //     ),
      //     SizedBox(
      //       width: 20.0,
      //     ),
      //   ],
      //   backgroundColor: Colors.blue.shade300,
      //   elevation: 0,
      // ),
      body: _widgetOptions.elementAt(_selectedIndex)
      //AppRoute.router.routerDelegate.build(context),
    );
  }
}
