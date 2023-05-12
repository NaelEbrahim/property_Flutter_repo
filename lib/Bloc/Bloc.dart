// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';

class MyBloc extends Cubit <Bloc_States>{

  MyBloc () : super ( Initial_State() ) ;

  static MyBloc get( context ) => BlocProvider.of( context ) ;

  bool eyeVisible = true ;
  IconData eyeIcon = Icons.visibility ;
  void ChangeEye () {
    eyeVisible = !eyeVisible ;
    eyeIcon = ( eyeVisible ) ? Icons.visibility : Icons.visibility_off ;
    emit(ChangeEyeIcon());
  }

  void login (Map <String ,dynamic> data) {
    emit(LoadingLoginState());
      Dio_Helper.postData(LOGIN,data).then((value){
        emit(SuccessLoginState());
    }).catchError((error){
        emit(ErrorLoginState(error));
    });
  }

  void Signup (Map <String,dynamic> data){
    emit(LoadingSignupState());
    Dio_Helper.postData(SIGNUP, data).then((value){
      print(value.data);
      emit(SuccessSignupState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorSignupState());
    });
  }

  void ChangeDropDown () {
    emit(ChangeDropdown());
  }

}