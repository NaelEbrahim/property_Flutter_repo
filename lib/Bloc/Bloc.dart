// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Models/Messages_Model.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';

class MyBloc extends Cubit<Bloc_States> {
  MyBloc() : super(Initial_State());

  static MyBloc get(context) => BlocProvider.of(context);

  bool eyeVisible = true;

  IconData eyeIcon = Icons.visibility;

  void ChangeEye() {
    eyeVisible = !eyeVisible;
    eyeIcon = (eyeVisible) ? Icons.visibility : Icons.visibility_off;
    emit(ChangeEyeIcon());
  }

  void login(Map<String, dynamic> data) {
    emit(LoadingLoginState());
    Dio_Helper.postData(LOGIN, data).then((value) {
      emit(SuccessLoginState());
    }).catchError((error) {
      emit(ErrorLoginState(error));
    });
  }

  void Signup(Map<String, dynamic> data) {
    emit(LoadingSignupState());
    Dio_Helper.postData(SIGNUP, data).then((value) {
      emit(SuccessSignupState());
    }).catchError((error) {
      emit(ErrorSignupState());
    });
  }

  void SendMessage({
    required String receiverId,
    required String datetime,
    required String hourWithminute,
    required String text,
  }) {
    Messages_Model message_model = Messages_Model(
        senderId: receiverId ,
        receiverId: '10031',
        datetime: datetime,
        houtWithminute: hourWithminute,
        text: text);

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

  void ChangeDropDown() {
    emit(ChangeDropdown());
  }
}
