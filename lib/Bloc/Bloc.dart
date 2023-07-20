// ignore_for_file: non_constant_identifier_names, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Models/Home_Model.dart';
import 'package:university_project_property_app/Models/Login_Model.dart';
import 'package:university_project_property_app/Models/Messages_Model.dart';
import 'package:university_project_property_app/Models/SignUp_Model.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class MyBloc extends Cubit<Bloc_States> {
  MyBloc() : super(Initial_State());

  static MyBloc get(context) => BlocProvider.of(context);


  final ImagePicker imagePicker = ImagePicker() ;
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

  Future Search ( Map <String , dynamic > data ) {
  emit(LoadingSearchProperty());
    return Dio_Helper.postData(
        url: SEARCH ,
        data: data
    ).then((value) {
      emit(SuccessSearchProperty());
      print(value.data);
    }).catchError((error){
      emit(ErrorSearchProperty(error.toString()));
      print(error.toString());
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
