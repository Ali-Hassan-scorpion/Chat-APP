import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Form_List_Ruff extends StatefulWidget {
  //final String title;
  //final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const Form_List_Ruff(
    {
      //required this.title,
      //required this.hint,
      this.controller,
      this.widget,
      //this.emailController,
      super.key});

  @override
  State<Form_List_Ruff> createState() => _Form_List_RuffState();
}

class _Form_List_RuffState extends State<Form_List_Ruff> {
  TextEditingController h_LtDate =TextEditingController();
  TextEditingController _DaDate = TextEditingController();
  TextEditingController _pickDate = TextEditingController();
  TextEditingController _EnDate = TextEditingController();
  
  TextEditingController emailController= TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(
            'Assign Task',
          ),
          // leading: BackButton(),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/1.jpg',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
          backgroundColor: Colors.blue.shade300,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: TextStyle(
                    //fontFamily: 'GoogleFonts.lato',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Letter Originated By

                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Letter Originated By',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: EdgeInsets.only(left: 14.0),
                  height: 52.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter the Department Name',
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Letter Originated Field End

                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Letter No',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width*0.453,
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        height: 52.0,
                        margin: EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          )
                        ),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter Letter No',
                      
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 10.0,
                    ),

                    Expanded(
                      child: Container(
                        height: 52.0,
                        margin: EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: h_LtDate,
                          autofocus: false,
                          readOnly: true,
                          cursorColor: Colors.grey,
                          textInputAction: null,
                          decoration: InputDecoration(
                            hintText: DateFormat.yMd().format(DateTime.now()),
                            suffixIcon: Icon(Icons.calendar_today),
                            focusedBorder: UnderlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          onTap: () async{
                            DateTime? LtDate = await showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(3000),
                              
                            );
                            if(LtDate !=null){
                              setState(() {
                                h_LtDate.text=DateFormat.yMd().format(LtDate);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // Letter NO and Date End

                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Dairy No',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width*0.453,
                    // ),

                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        margin: EdgeInsets.only(top: 8.0),
                        height: 52.0,
                        padding: EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          )
                        ),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Diary No',

                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.0,),

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: _DaDate,
                          autofocus: false,
                          cursorColor: Colors.grey,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: DateFormat.yMd().format(DateTime.now()),
                            suffixIcon: Icon(Icons.calendar_today),

                            focusedBorder: UnderlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            enabledBorder:
                            UnderlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),

                          onTap: () async{
                            DateTime? DaDate= await showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(3000),
                            );

                            if(DaDate!=null){
                              setState(() {
                                _DaDate.text= DateFormat.yMd().format(DaDate);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // Diary No && Date End

                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      //color: Get.isDarkMode?Colors.white:Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: 52.0,
                  margin: EdgeInsets.only(top: 8.0),
                  padding: EdgeInsets.only(left: 14.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'Enter your title',
                            // hintStyle: TextStyle(
                            //   color: Colors.black,
                            // ),
                            //border: InputBorder.none,
                            focusedBorder: 
                            //OutlineInputBorder( 
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(
                            //     color: Colors.blue,
                            //   )
                            // ),
                            UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            ),
                            enabledBorder: 
                            // OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(
                            //     color: Colors.grey,
                            //     width: 1,
                            //   )
                            // ),
                            UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                      ),
                    ),
                    ],
                  ),
                ),

                // Note Field

                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      //color: Get.isDarkMode?Colors.white:Colors.black,
                    ),
                  ),
                ),
              
                Container(
                  height: 52.0,
                  margin: EdgeInsets.only(top: 8.0),
                  padding: EdgeInsets.only(left: 14.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          autofocus: false,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'Enter brief description',
                            // hintStyle: TextStyle(
                            //   color: Colors.black,
                            // ),
                            border: InputBorder.none,
                            focusedBorder: 
                            //OutlineInputBorder( 
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(
                            //     color: Colors.blue,
                            //   )
                            // ),
                            UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            ),
                            enabledBorder: 
                            // OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(
                            //     color: Colors.grey,
                            //     width: 1,
                            //   )
                            // ),
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                      ),
                    ),
                    ],
                  ),
                ),

                // Note Field End

                // Assigned to Field
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Assigned to',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                             color: Colors.grey,
                             width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Select the Participant',

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // For Date Field
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            //color: Get.isDarkMode?Colors.white:Colors.black,
                          ),
                        ),
                      ),
                      
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width*0.325,
                      // ),

                       Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            //color: Get.isDarkMode?Colors.white:Colors.black,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                
                
                Container(
                  height: 52.0,
                  margin: EdgeInsets.only(top: 8.0),
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //     width: 1.0,
                  //   ),
                  //   borderRadius: BorderRadius.circular(12)
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 14),decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                          child: TextFormField(
                            //readOnly: widget==null?false:true,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            cursorColor: Colors.grey,
                            controller: _pickDate,
                            onTap: () async{
                              //_selectDate(context);
                              //print('New button');
                              //_getDateFromUser();
                              //_selectDate();
                              DateTime? pickDate= await showDatePicker(
                                context: context, 
                                initialDate: DateTime.now(), 
                                firstDate: DateTime(2000), 
                                lastDate: DateTime(3000),
                              );

                             if(pickDate !=null){
                              setState(() {
                                _pickDate.text= DateFormat.yMd().format(pickDate);
                              });
                             }
                            },
                            decoration: InputDecoration(
                              hintText: DateFormat.yMd().format(DateTime.now()),
                              // suffixIcon: GestureDetector(
                              //   // onTap: (){
                                  
                              //   //   //print('Clicked');
                              //   //   //_selectDate();
                              //   //   //_getDateFromUser();
                              //   // },
                              //   child: Icon(Icons.calendar_today),
                              // ),
                             suffixIcon: const Icon(Icons.calendar_today),
                              // hintStyle: TextStyle(
                              //   color: Colors.black,
                              // ),
                              border: InputBorder.none,
                              focusedBorder: 
                              //OutlineInputBorder( 
                              //   borderRadius: BorderRadius.circular(12),
                              //   borderSide: BorderSide(
                              //     color: Colors.blue,
                              //   )
                              // ),
                              UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                )
                              ),
                              enabledBorder: 
                              // OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(12),
                              //   borderSide: BorderSide(
                              //     color: Colors.grey,
                              //     width: 1,
                              //   )
                              // ),
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                            ),
                                              ),
                        ),
                    ),
                      SizedBox(width: 10,),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 14),
                          decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                          child: TextFormField(
                            //readOnly: widget==null?false:true,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            cursorColor: Colors.grey,
                            controller: _EnDate,
                            onTap: () async{
                              //_selectDate(context);
                              //print('New button');
                              //_getDateFromUser();
                              //_selectDate();
                              DateTime? EnDate= await showDatePicker(
                                context: context, 
                                initialDate: DateTime.now(), 
                                firstDate: DateTime(2000), 
                                lastDate: DateTime(3000)
                              );

                              if(EnDate!=null){
                                setState(() {
                                  _EnDate.text=DateFormat.yMd().format(EnDate);
                                });
                              }
                             
                            },
                            decoration: InputDecoration(
                              hintText: DateFormat.yMd().format(DateTime.now()),
                              // suffixIcon: GestureDetector(
                              //   // onTap: (){
                                  
                              //   //   //print('Clicked');
                              //   //   //_selectDate();
                              //   //   //_getDateFromUser();
                              //   // },
                              //   child: Icon(Icons.calendar_today),
                              // ),
                             suffixIcon: const Icon(Icons.calendar_today),
                              // hintStyle: TextStyle(
                              //   color: Colors.black,
                              // ),
                              border: InputBorder.none,
                              focusedBorder: 
                              //OutlineInputBorder( 
                              //   borderRadius: BorderRadius.circular(12),
                              //   borderSide: BorderSide(
                              //     color: Colors.blue,
                              //   )
                              // ),
                              UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                )
                              ),
                              enabledBorder: 
                              // OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(12),
                              //   borderSide: BorderSide(
                              //     color: Colors.grey,
                              //     width: 1,
                              //   )
                              // ),
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                            ),
                                              ),
                        ),
                    ),
                    ],
                  ),
                ),

                //Date Field End

                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                            onPressed:(){
                
                            },child: Text('High'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 10.3,
                                //fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Red Button End
                      SizedBox(width: 5.0,),
                
                      Expanded(
                        child: Container(
                          child: ElevatedButton(onPressed: () {
                            
                          },child: Text('Medium'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 10.3,
                              //fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        ),
                      ),
                
                      SizedBox(width: 5.0,),
                
                      Expanded(
                        child: Container(
                          child: ElevatedButton(onPressed: () {
                            
                          },child: Text('Low'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 10.3,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        ),
                      ),
                      // Low Button End
                
                      SizedBox(width: 80.0,),
                
                      Expanded(
                        child: Container(
                          height: 60.0,
                          width: 50.0,
                          child: ElevatedButton(onPressed: () {
                            
                          },child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(0.0),
                            textStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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
             
      );
  }
}