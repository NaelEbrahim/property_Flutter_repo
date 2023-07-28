// ignore_for_file: non_constant_identifier_names, file_names, prefer_typing_uninitialized_variables
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


  void AddToSelectedImages () async {
    List <XFile> SelectedImages = await ImagePicker().pickMultiImage() ;
    if ( SelectedImages.isNotEmpty ){
     FileToimages.addAll(SelectedImages);
     xFilesToFiles(SelectedImages);
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
          'user_id' : login_model!.user_data!.id.toString()
        });
      }
      emit(SuccessLoginState());
    }).catchError((error) {

      emit(ErrorLoginState(error.toString()));
    });
  }

  SignUp_Model ? signUp_Model ;
  void Signup( var data) {
    emit(LoadingSignupState());
    Dio_Helper.postData(url: SIGNUP,data:  data).then((value) {
      signUp_Model = SignUp_Model.fromjson(value.data);
      sharedPreferences.putData(signUp_Model!.token);
      sharedPreferences.putUserData({
        'user_name' : signUp_Model!.user_data!.name.toString(),
        'user_id' : signUp_Model!.user_data!.id.toString()
      });
      emit(SuccessSignupState());
    }).catchError((error) {
      emit(ErrorSignupState());
    });
  }


  void AddProperty ({required data ,required header}){
      emit(LoadingAddProperty());
   Dio_Helper.postData(
       url: ADDPROPERTY,
       data: data,
       headers: header
   ).then((value) {
      emit(SuccessAddProperty());
   }).catchError((error){
      emit(ErrorAddProperty(error.toString()));
      print(error.toString());
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
      emit(SuccessFilterProperty());
    }).catchError((error){
     emit(ErrorFilterProperty(error.toString()));
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
        senderId: sharedPreferences.getUserData()['user_id'],
        receiverId: receiverId,
        datetime: datetime,
        houtWithminute: hourWithminute,
        text: text);

    FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc(sharedPreferences.getUserData()['user_id'])
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
        .doc(sharedPreferences.getUserData()['user_id'])
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
        .doc(sharedPreferences.getUserData()['user_id'])
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

  var imagepath ;
  Future getGallaryImage(BuildContext context) async {
    XFile ? inputimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (inputimage != null) {
      imagepath = inputimage.path;
    }
  }

  void changeimage(BuildContext context) {
    getGallaryImage(context).then((value) {
      emit(ChangeAnyState());
    });
  }


  var selectedIndex = 0 ;
  void ChangePropertyCategory (int index){
    selectedIndex = index ;
    emit(ChangeAnyState());
  }

}
