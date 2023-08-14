// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/GetUserProfile_Model.dart';
import 'package:university_project_property_app/Modules/Chatting/Message_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class Chat_Screen extends StatelessWidget {
  const Chat_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBloc()..GetMyChats(),
      child: BlocConsumer<MyBloc, Bloc_States>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: myAppColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: reusableText(
                    text: 'Messages', fontsize: 20.0, fontColor: Colors.white),
              ),
              body: ConditionalBuilder(
                condition: cubit.getMyChats_Model != null && usersData.length == cubit.getMyChats_Model!.mychatsIds.length,
                builder: (context) => (usersData.isNotEmpty)
                    ? Container(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              BuildContacts(context, usersData[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount:
                              cubit.getMyChats_Model!.mychatsIds.length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      )
                    : Center(
                        child: Image.asset('images/nomessages.png',
                            height: 200.0, width: 200.0)),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ));
        },
      ),
    );
  }

  Widget BuildContacts(BuildContext context, GetUserProfile_Model item) =>
      InkWell(
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(item.image[0].toString()),
              radius: 35.0,
            ),
            const SizedBox(width: 10.0),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              reusableText(
                  text: item.name.toString().toUpperCase(), fontsize: 17.0),
              reusableText(
                  text: 'Don\'t forget I will wait you',
                  fontsize: 12.0,
                  fontColor: Colors.grey),
            ]),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //   reusableText(text: '9:43AM', fontsize: 12,fontColor: Colors.grey,fontWeight: FontWeight.bold),
                  //  const SizedBox(height: 7.0),
                  if (item.unreadMessages != 0)
                    CircleAvatar(
                      radius: 13.0,
                      backgroundColor: myAppColor,
                      child: reusableText(
                          text: item.unreadMessages.toString(),
                          fontsize: 12,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                ],
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Message_Screen({
                        'ownerId': item.id.toString(),
                        'ownername': item.name,
                        'ownerimage': item.image,
                        'ownerphone': item.phone.toString()
                      })));
        },
      );
}
