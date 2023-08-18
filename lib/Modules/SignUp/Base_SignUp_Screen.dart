// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
import 'package:university_project_property_app/Modules/SignUp/SignUp1_Screen.dart';
import 'package:university_project_property_app/Modules/SignUp/SignUp2_Screen.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class Base_SignUp_Screen extends StatelessWidget {
   Base_SignUp_Screen({Key? key}) : super(key: key);

   Future <bool> onWillPop (BuildContext context) async {
     if(MyBloc.get(context).selectedIndex == 1){
        MyBloc.get(context).ChangePropertyCategory(0);
     }
     else{
       Navigator.pop(context);
     }
     return false  ;
   }

  List <Widget> screens = [
    SignUp1_Screen(),
    SignUp2_Screen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc , Bloc_States>(
        listener: (context, state) {
          if (state is SuccessSignupState) {
            if ( MyBloc.get(context).signUp_Model!.token != null ) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Base_Screen()),(route) => false);
              Fluttertoast.showToast(
                  msg: 'Welcome  ${MyBloc.get(context).signUp_Model!.user_data!.name.toString().toUpperCase()}',
                  toastLength:
                  Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor:
                  Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            else{
              Fluttertoast.showToast(
                  msg: 'Email / Phone is Already used or you enter worng data',
                  toastLength:
                  Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor:
                  Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = MyBloc.get(context);
            return WillPopScope(
               onWillPop: () async => await onWillPop(context),
               child: Scaffold(
                  backgroundColor: ScaffoldColorLight,
                  body: SafeArea(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                                  child: screens[cubit.selectedIndex]
                              ),
                            ],
                          )
                      )
                  ),
                ),
            );
        },
      ),
    );
  }
}
