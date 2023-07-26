// ignore_for_file: non_constant_identifier_names, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Models/Filter_Model.dart';
import 'package:university_project_property_app/Models/Home_Model.dart';
import 'package:university_project_property_app/Models/Login_Model.dart';
import 'package:university_project_property_app/Models/Messages_Model.dart';
import 'package:university_project_property_app/Models/Search Model.dart';
import 'package:university_project_property_app/Models/SignUp_Model.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';
import 'package:university_project_property_app/Shared/Resources.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';

class MyBloc extends Cubit<Bloc_States> {
  MyBloc() : super(Initial_State());

  static MyBloc get(context) => BlocProvider.of(context);


  final ImagePicker imagePicker = ImagePicker () ;
  void AddToSelectedImages () async {
    final List <XFile> SelectedImages = await imagePicker.pickMultiImage() ;
    if ( SelectedImages.isNotEmpty ){
     FileToimages.addAll(SelectedImages);
    }
    emit(ChangeAnyState());
  }

  void DeleteFromSelectedImages (int index) {
    FileToimages.removeAt(index);
    emit(ChangeAnyState());
  }


  bool eyeVisible = true;

  IconData eyeIcon = Icons.visibility;

  void ChangeEye() {
    eyeVisible = !eyeVisible;
    eyeIcon = (eyeVisible) ? Icons.visibility : Icons.visibility_off;
    emit(ChangeEyeIcon());
  }

  Login_Model ? login_model ;
  void login(Map<String, dynamic> data) {
    emit(LoadingLoginState());
    Dio_Helper.postData(url: LOGIN,data: data).then((value) {
      login_model = Login_Model.fromjson(value.data);
      if( login_model!.token != null ) {
        sharedPreferences.putData(login_model!.token);
        sharedPreferences.putUserData({
          'user_name' : login_model!.user_data!.name.toString(),
        });
      }
      emit(SuccessLoginState());
    }).catchError((error) {

      emit(ErrorLoginState(error.toString()));
    });
  }

  SignUp_Model ? signUp_Model ;
  void Signup(Map<String, dynamic> data) {
    emit(LoadingSignupState());
    Dio_Helper.postData(url: SIGNUP,data:  data).then((value) {
      signUp_Model = SignUp_Model.fromjson(value.data);
      sharedPreferences.putData(signUp_Model!.token);
      emit(SuccessSignupState());
    }).catchError((error) {
      emit(ErrorSignupState());
    });
  }


  void AddProperty ({
  required Map <String , dynamic > data ,
  required header   
  }){
      emit(LoadingAddProperty());
   Dio_Helper.postData(
       url: ADDPROPERTY,
       data: data,
       headers: header
   ).then((value) {
      emit(SuccessAddProperty());
   }).catchError((error){
     print(error.toString());
      emit(ErrorAddProperty(error.toString()));
  });
}

Home_Model ? home_model ;
Future GetAllProperty () {
    emit(LoadingGetAllProperty());
    return Dio_Helper.getData(
        GETALLPROPERTY).then((value){
          home_model = Home_Model.fromjson(value.data);
          emit(SuccessGetAllProperty());
    }
    ).catchError((error){
      emit(ErrorGetAllProperty(error.toString()));
      print(error.toString());
    });
}

  Search_Model ? search_model ;
  Future Search ( Map <String , dynamic > data ) {
    if ( search_model != null ) {
      search_model!.propertylist = [] ;
    }
  emit(LoadingSearchProperty());
    return Dio_Helper.postData(
        url: SEARCH ,
        data: data
    ).then((value) {
      search_model = Search_Model.fromjson(value.data['result']);
      emit(SuccessSearchProperty());
    }).catchError((error){
      emit(ErrorSearchProperty(error.toString()));
      print(error.toString());
    });
  }


  Filter_Model ? filter_model ; 
  Future filter (Map <String , dynamic> data ) {
    emit(LoadingFilterProperty());
    return Dio_Helper.postData(
       url: FILTER,
       data: data
   ).then((value) {
     filter_model = Filter_Model.fromjson(value.data['properties']);
     print(filter_model!.propertylist[0].area);
      emit(SuccessFilterProperty());
    }).catchError((error){
     emit(ErrorFilterProperty(error.toString()));
     print(error.toString());
    });
  }

  Future Logout ( header ) {
    emit(LoadingLogoutProperty());
    return Dio_Helper.postData(
        url: LOGOUT,
        data: {},
        headers: header
    ).then((value) {
      emit(SuccessLogoutProperty());
    }).catchError((error){
      emit(ErrorLogoutProperty(error.toString()));
    });
  }

  //Chatting 
  void SendMessage({
    required String receiverId,
    required String datetime,
    required String hourWithminute,
    required String text,
  }) {
    Messages_Model message_model = Messages_Model(
        senderId: '10031' ,
        receiverId: receiverId,
        datetime: datetime,
        houtWithminute: hourWithminute,
        text: text);

    FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc('10031')
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(message_model.tomap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });

    FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc(receiverId)
        .collection('chats')
        .doc('10031')
        .collection('messages')
        .add(message_model.tomap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
  }

  List <Messages_Model> messages = [];
  Messages_Model ? messages_model ;
  void GetMessages({required receiverId}) {
    FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc('10031')
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
          messages = [] ;
          for (var element in event.docs) {
            messages.add(Messages_Model.fromjson(element.data()));
          }
      emit(SuccessGetMessagesState());
    });
  }

  void ChangeState () {
    emit(ChangeAnyState());
  }

  var selectedIndex = 0 ;
  void ChangePropertyCategory (index){
    selectedIndex = index ;
    emit(ChangeAnyState());
  }

}
