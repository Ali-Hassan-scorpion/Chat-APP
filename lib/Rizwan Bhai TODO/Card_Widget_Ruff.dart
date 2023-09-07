import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Card_Widget_Ruff extends StatelessWidget {
  const Card_Widget_Ruff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assigned Task Ruff'
        ),
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade100,
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.02,
                          ),
                          width: MediaQuery.of(context).size.width * 0.72,
                          // height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                                height: 30.0,
                                // MediaQuery.of(context).size.height * 0.05,
                                width: 200.0,
                                // MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade400,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Department Name',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15.0),
                              //MediaQuery.of(context).size.height *0.02),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: EdgeInsets.only(left: 8.0),
                                  // MediaQuery.of(context).size.width *0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *0.45,
                                        child: Text(
                                          'Task title',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 90.0,
                                      // ),
                                      Text(
                                        DateFormat.yMd().format(DateTime.now()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 8.0,),
                                      // MediaQuery.of(context).size.width * 0.02,
                                  
                                  // MediaQuery.of(context).size.height *0.01),
                              child: Text(
                                'Assigned by:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 8.0,),
                              // padding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.02,
                              //     top: MediaQuery.of(context).size.height *
                              //         0.01),
                              child: Text(
                                'Brief Description:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 8.0,),
                              // padding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.02,
                              //     top: MediaQuery.of(context).size.height *
                              //         0.01),
                              child: Text(
                                'Start Date:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 8.0,),
                              // padding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.02,
                              //     top: MediaQuery.of(context).size.height *
                              //         0.01),
                              child: Text(
                                'End Date:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10.0, right: 10),
                              margin: EdgeInsets.only(top: 20.0),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    child: Row(
                                      children: [
                                        Container(
                                          //width: 5.0,

                                        ),
                                        Container(
                                          //width: 20,
                                          //width: MediaQuery.of(context).size.width*0.3,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Icon(Icons.delete),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              elevation: 4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width *
                                  //       0.15,
                                  // ),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      //width: 30.0,
                                      //MediaQuery.of(context).size.width*0.45,
                                      child: ElevatedButton(
                                        onPressed: () {}, 
                                        child: Text('Complete',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 70.0,
                    width: 80.0,
                    margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: ElevatedButton(onPressed: () {
                      
                      // context.go("/b");
    
                    }, child: const Text('Press'),
                    ),
                  ),
                ),
                // Container(
                //   color: Colors.blue,
                //   height: 200,
                // )
              ],
            ),
          ),
        ),
    );
  }
}