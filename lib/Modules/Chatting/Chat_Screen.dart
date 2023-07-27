// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:university_project_property_app/Modules/Chatting/Message_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';


class Chat_Screen extends StatelessWidget {
   const Chat_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: myAppColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: myAppColor,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back_ios_new_outlined),
         onPressed: (){},
       ),
        centerTitle: true,
        title: reusableText(
            text: 'Messages',
            fontsize: 20.0,
            fontColor: Colors.white
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: (){}
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            itemBuilder: (context, index) => BuildContacts(context),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
        ),
      ),
    ) ;
  }

  Widget BuildContacts (BuildContext context) => InkWell(
    child: Row(
      children:  [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?w=740&t=st=1684829039~exp=1684829639~hmac=1fcea6b939b685a82ea101268e3922325fc945b4c1eef0cb5e21d46ffc0e09d7'),
          radius: 35.0,
        ),
        const SizedBox(width: 10.0),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableText(text: "Sami Wilson", fontsize: 17.0),
              reusableText(text: 'Don\'t forget I will wait you', fontsize: 12.0,fontColor: Colors.grey),
            ]),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            reusableText(text: '9:43AM', fontsize: 12,fontColor: Colors.grey,fontWeight: FontWeight.bold),
            const SizedBox(height: 7.0),
            CircleAvatar(
              radius: 13.0,
              backgroundColor: myAppColor ,
              child: reusableText(text: '3', fontsize: 12,fontColor: Colors.white,fontWeight: FontWeight.bold),
            )
          ],
          ),
        )
      ],
    ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Message_Screen({}),));
    },
  ) ;

}
