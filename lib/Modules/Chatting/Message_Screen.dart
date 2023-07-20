// ignore_for_file: camel_case_types, file_names, must_be_immutable, non_constant_identifier_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/Messages_Model.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';


class Message_Screen extends StatelessWidget {
  Message_Screen({Key? key}) : super(key: key);

  var messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc()..GetMessages(receiverId: '10052'),
      child: BlocConsumer <MyBloc , Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myAppColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: reusableText(
                  text: 'Sami Wilson',
                  fontsize: 20.0,
                  fontColor: Colors.white
              ),
              actions: [
                IconButton(
                    padding: const EdgeInsets.only(right: 10.0),
                    icon: const Icon(Icons.phone),
                    onPressed: (){}
                )
              ],
            ),
            body: ConditionalBuilder(
              condition:  cubit.messages.isNotEmpty || state is SuccessGetMessagesState ,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = MyBloc.get(context).messages[index];
                            if ( message.senderId == '10031' ) {
                                return SendMyMessage(message) ;
                              }
                            return SendMessage(message) ;
                          },
                          separatorBuilder:(context, index) => const SizedBox(height: 10.0),
                          itemCount: MyBloc.get(context).messages.length
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: myAppColor,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messagecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Message',
                                prefixIcon: Icon(Icons.telegram)
                              ),
                            ),
                          ),
                           Container(
                             color: myAppColor,
                             child: MaterialButton(
                                onPressed: (){
                                  cubit.SendMessage(
                                      receiverId: '10052',
                                      datetime: DateTime.now().toString(),
                                      hourWithminute: '${DateTime.now().hour}:${DateTime.now().minute}',
                                      text: messagecontroller.text
                                  );
                                  messagecontroller.text = '' ;
                                },
                              minWidth: 1.0,
                              child: const Icon(Icons.send,color: Colors.white,size: 16.0),
                          ),
                           )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            )
          );
        },
      ) ,
    );
  }

  Widget SendMessage ( Messages_Model message ) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?w=740&t=st=1684829039~exp=1684829639~hmac=1fcea6b939b685a82ea101268e3922325fc945b4c1eef0cb5e21d46ffc0e09d7'),
              radius: 25.0,
            ),
            const SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Colors.grey
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0
                  ),
                  child: reusableText(
                      text: message.text!,
                      fontsize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.white
                  ),
                ),
                reusableText(text: message.houtWithminute!, fontsize: 11.0,fontColor: Colors.grey,fontWeight: FontWeight.bold)
              ],
            )
          ],
        ),
  ) ;

  Widget SendMyMessage ( Messages_Model message ) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: myAppColor
          ),
          padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0
          ),
          child: reusableText(
              text: message.text!,
              fontsize: 15.0,
              fontWeight: FontWeight.w500,
              fontColor: Colors.white
          ),
        ),
        reusableText(text: message.houtWithminute!, fontsize: 11.0,fontColor: Colors.grey,fontWeight: FontWeight.bold)
      ],
    ),
  ) ;

}
