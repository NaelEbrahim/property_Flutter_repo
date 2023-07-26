// ignore_for_file: unnecessary_this, camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, prefer_initializing_formals, file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/App_Bars.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class Picked_Images extends StatelessWidget {

  Future <bool> onWillPop (BuildContext context) async {
    Navigator.of(context).pop() ;
    return false  ;
  }

  @override
  Widget build(BuildContext context)  {
    return  BlocProvider(
      create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc , Bloc_States> (
        listener: (context, state) => {},
        builder: (context, state) {
            return WillPopScope(
            onWillPop:  () async => await onWillPop(context),
            child: Scaffold(
              appBar: Picked_Images_AppBar(context),
              body: Center(
                child: ( FileToimages.isNotEmpty ) ? Column(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10.0 ,
                                  crossAxisSpacing: 10.0 ),
                              itemBuilder: (context , index) => BuildGridView(index , context),
                              itemCount: FileToimages.length,
                            )))
                  ],
                ) :
                  Image.asset('images/noImages.png',height: 200,width: 200,)
              ),
            ),
          );
          },
      )
    );
  }

  Widget BuildGridView (int index ,BuildContext context ) {
    return GestureDetector(
      onLongPress: (){
        ShowDeleteDialog(index , context);
      },
      child: SizedBox(
        height: 100.0,
        width: ( MediaQuery.of(context).size.width / 3 ) - 40,
        child: Image.file(File(FileToimages[index].path),
            fit: BoxFit.cover),
      ),
    );
  }

  void ShowDeleteDialog(int index , BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: reusableText(text: 'Delete Item?', fontsize: 15.0),
          content: reusableText(text: 'Are you sure you want to delete this item?', fontsize: 15.0),
          actions: <Widget> [
            reusableTextButton(
              context: context,
              buttontext: 'Cancel',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              function: (){
                Navigator.of(context).pop();
            }),
            reusableTextButton(
                context: context,
                buttontext: 'Delete',
                fontSize: 12.0,
                textColor: Colors.red,
                fontWeight: FontWeight.bold,
                function: (){
                  MyBloc.get(context).DeleteFromSelectedImages(index);
                  Navigator.of(context).pop();
            }),
          ],
        );
      },
    );
  }

}
