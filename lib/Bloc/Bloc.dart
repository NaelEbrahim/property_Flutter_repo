// ignore_for_file: non_constant_identifier_names, file_names, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Models/BuyProperty_Model.dart';
import 'package:university_project_property_app/Models/Filter_Model.dart';
import 'package:university_project_property_app/Models/GetMyBankAccount_Model.dart';
import 'package:university_project_property_app/Models/GetMyChats_Model.dart';
import 'package:university_project_property_app/Models/HomeSlide_Model.dart';
import 'package:university_project_property_app/Models/Home_Model.dart';
import 'package:university_project_property_app/Models/Login_Model.dart';
import 'package:university_project_property_app/Models/Messages_Model.dart';
import 'package:university_project_property_app/Models/Profile_Model.dart';
import 'package:university_project_property_app/Models/Search Model.dart';
import 'package:university_project_property_app/Models/ShowFavorite_Model.dart';
import 'package:university_project_property_app/Models/SignUp_Model.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';
import '../Models/GetUserProfile_Model.dart';

class MyBloc extends Cubit<Bloc_States> {
  MyBloc() : super(Initial_State());

  static MyBloc get(context) => BlocProvider.of(context);

  void AddToSelectedImages() async {
    List<XFile> SelectedImages = await ImagePicker().pickMultiImage();
    if (SelectedImages.isNotEmpty) {
      FileToimages.addAll(SelectedImages);
      xFilesToFiles(SelectedImages);
    }
    emit(ChangeAnyState());
  }

  void DeleteFromSelectedImages(int index) {
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

  Login_Model? login_model;

  void login(Map<String, dynamic> data) {
    emit(LoadingLoginState());
    Dio_Helper.postData(url: LOGIN, data: data).then((value) {
      login_model = Login_Model.fromjson(value.data);
      if (login_model!.token != null) {
        sharedPreferences.putData(login_model!.token);
        sharedPreferences.putUserData({
          'user_name': login_model!.user_data!.name.toString(),
          'user_id': login_model!.user_data!.id.toString()
        });
      }
      emit(SuccessLoginState());
    }).catchError((error) {
      emit(ErrorLoginState(error.toString()));
    });
  }

  SignUp_Model? signUp_Model;

  void Signup(var data) {
    emit(LoadingSignupState());
    Dio_Helper.postData(url: SIGNUP, data: data).then((value) {
      signUp_Model = SignUp_Model.fromjson(value.data);
      sharedPreferences.putData(signUp_Model!.token);
      sharedPreferences.putUserData({
        'user_name': signUp_Model!.user_data!.name.toString(),
        'user_id': signUp_Model!.user_data!.id.toString()
      });
      emit(SuccessSignupState());
    }).catchError((error) {
      emit(ErrorSignupState());
    });
  }

  void AddProperty({required data, required header}) {
    emit(LoadingAddProperty());
    Dio_Helper.postData(url: ADDPROPERTY, data: data, headers: header)
        .then((value) {
      emit(SuccessAddProperty());
    }).catchError((error) {
      emit(ErrorAddProperty(error.toString()));
    });
  }

  Home_Model? home_model;

  Future GetAllProperty() {
    emit(LoadingGetAllProperty());
    return Dio_Helper.getData(url: GETALLPROPERTY).then((value) {
      home_model = Home_Model.fromjson(value.data);
      emit(SuccessGetAllProperty());
    }).catchError((error) {
      emit(ErrorGetAllProperty(error.toString()));
    });
  }

  HomeSlider_Model ? homeSlider_Model ;
  Future HomeSlider () {
    emit(LoadingGetHomeSlider());
    return Dio_Helper.getData(url: HOMESLIDER).then((value) {
      homeSlider_Model = HomeSlider_Model.formjson(value.data);
      emit(SuccessGetHomeSlider());
    }).catchError((error){
      ErrorGetHomeSlider(error.toString());
    });
  }

  Future UserRate ( Map <String , dynamic> data ) {
    emit(LoadingUserRate());
    return Dio_Helper.postData(
        url: USERRATE,
        data: data,
        headers: sharedPreferences.getData('token').toString()
    ).then((value) {
      // For Fix Hard Problem ( No Other Choice )
      Fluttertoast.showToast(
          msg: 'Thank you for review',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //
      emit(SuccessUserRate());
    }).catchError((error){
      emit(ErrorUserRate(error.toString()));
    });
  }

  Search_Model? search_model;
  Future Search(Map<String, dynamic> data) {
    if (search_model != null) {
      search_model!.propertylist = [];
    }
    emit(LoadingSearchProperty());
    return Dio_Helper.postData(url: SEARCH, data: data).then((value) {
      search_model = Search_Model.fromjson(value.data['result']);
      emit(SuccessSearchProperty());
    }).catchError((error) {
      emit(ErrorSearchProperty(error.toString()));
    });
  }

  Filter_Model? filter_model;

  Future filter(Map<String, dynamic> data) {
    emit(LoadingFilterProperty());
    return Dio_Helper.postData(url: FILTER, data: data).then((value) {
      filter_model = Filter_Model.fromjson(value.data['properties']);
      emit(SuccessFilterProperty());
    }).catchError((error) {
      emit(ErrorFilterProperty(error.toString()));
    });
  }

  Profile_Model ? profile_model;
  Future GetMyProfile() {
    emit(LoadingGetUserProfile());
    return Dio_Helper.postData(
            url: GETMYPROFILE,
            data: {},
            headers: sharedPreferences.getData('token').toString())
        .then((value) {
      profile_model = Profile_Model.fromjson(value.data);
      emit(SuccessGetUserProfile());
    }).catchError((error) {
      emit(ErrorGetUserProfile(error.toString()));
    });
  }

  BuyProperty_Model ? buyProperty_Model ;
  Future BuyAndRentProperty ( {required String Url , required Map <String , dynamic> data} ){
    emit(LoadingBuyOrRentProperty());
    return Dio_Helper.postData(
        url: Url,
        data: data,
        headers: sharedPreferences.getData('token').toString()
    ).then((value) {
      buyProperty_Model = BuyProperty_Model.fromjson(value.data);
      emit(SuccessBuyOrRentProperty());
    }).catchError((error){
      emit(ErrorBuyOrRentProperty(error.toString()));
    });
  }

  Future UpdateUserProfile ( data ) {
    emit(LoadingUpdateUserProfile());
    return Dio_Helper.postData(
        url: UPDATEMYPROFILE ,
        data: data,
        headers: sharedPreferences.getData('token').toString()
    ).then((value) {
      emit(SuccessUpdateUserProfile());
    }).catchError((error){
      emit(ErrorUpdateUserProfile(error.toString()));
    });
  }

  Future GetUserProfile ( userId ){
    return Dio_Helper.getData(
        url: '$GETPERSONPROFILE/$userId'
    ).then((value) async {
      int ? unreadmessages ;
      await FirebaseFirestore.instance
          .collection('UsersCollection')
          .doc(sharedPreferences.getUserData()['user_id'])
          .collection('chats')
          .doc(userId)
          .get()
          .then((snapshot){
        unreadmessages = snapshot.get('UnreadMasseges');
      });
      if ( unreadmessages != null ) {
        usersData.add(GetUserProfile_Model.fromjson(value.data['user'] , unreadmessages ));
      }
      emit(SuccessGetUserProfile());
    }).catchError((error){
      emit(ErrorGetUserProfile(error.toString()));
    });
  }

  GetMyBankAccount_Model ? getMyBankAccount_model ;
  Future GetMyBankAccount () {
    return Dio_Helper.getData(
      url: MYBANKACCOUNT,
      headers: sharedPreferences.getData('token').toString()
    ).then((value){
      getMyBankAccount_model = GetMyBankAccount_Model.fromjson(value.data['result']);
      if ( value.data['result'] != null ) {
        sharedPreferences.putBankAccount(getMyBankAccount_model!.number_account);
      }
      emit(SuccessGetMyBankAccount());
    }).catchError((error){
      emit(ErrorGetMyBankAccount(error.toString()));
    });
  }

  Future Logout(header) {
    emit(LoadingUserLogout());
    return Dio_Helper.postData(url: LOGOUT, data: {}, headers: header)
        .then((value) {
      usersData = [] ;
      user_property = [] ;
      emit(SuccessUserLogout());
      sharedPreferences.logout();
    }).catchError((error) {
      emit(ErrorUserLogout(error.toString()));
    });
  }

  Future AddToFavorite ( propertyId ) {
    emit(LoadingAddToFavorite());
    return Dio_Helper.postData(
        url: '$ADDTOFAVORITE/$propertyId',
        data: {},
        headers: sharedPreferences.getData('token').toString()
    ).then((value) {
      emit(SuccessAddToFavorite());
    }).catchError((error){
      emit(ErrorAddToFavorite(error.toString()));
    });
  }
  
  Future DeleteFavorite ( property_id ) {
    emit(LoadingDeleteFromFavorite());
    return Dio_Helper.postData(
        url: DELETEFAVORITE,
        headers: sharedPreferences.getData('token'),
        data: {'id_property' : property_id}
    ).then((value) {
      emit(SuccessDeleteFromFavorite());
    }).catchError((error){
      emit(ErrorDeleteFromFavorite(error.toString()));
    });
  }

  ShowFavorite_Model ? showFavorite_Model ;
  Future ShowUserFavorite () {
    emit(LoadingShowUserFavorite());
    return Dio_Helper.getData(
        url: SHOWFAVORITE,
        headers: sharedPreferences.getData('token')).
    then((value) {
      showFavorite_Model = ShowFavorite_Model.fromjson(value.data['result']);
      emit(SuccessShowUserFavorite());
    }).catchError((error){
      emit(ErrorShowUserFavorite(error.toString()));
    });
  }

  //Chatting
  void SendMessage({
    required String receiverId,
    required String datetime,
    required String hourWithminute,
    required String text,
  }) {
    int? UnreadMessages;
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

    // Save Same Massege to other person
    FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc(receiverId)
        .collection('chats')
        .doc(sharedPreferences.getUserData()['user_id'])
        .collection('messages')
        .add(message_model.tomap())
        .then((value) {
      // Update the number of unread masseges to other person
      FirebaseFirestore.instance
          .collection('UsersCollection')
          .doc(receiverId)
          .collection('chats')
          .doc(sharedPreferences.getUserData()['user_id'])
          .get()
          .then((snapshot) {
        if (snapshot.exists && snapshot.data()!.containsKey('UnreadMasseges')) {
          UnreadMessages = snapshot.get('UnreadMasseges');
          FirebaseFirestore.instance
              .collection('UsersCollection')
              .doc(receiverId)
              .collection('chats')
              .doc(sharedPreferences.getUserData()['user_id'])
              .update({'UnreadMasseges': UnreadMessages! + 1});
        } else {
          FirebaseFirestore.instance
              .collection('UsersCollection')
              .doc(receiverId)
              .collection('chats')
              .doc(sharedPreferences.getUserData()['user_id'])
              .set({'UnreadMasseges': 1}, SetOptions(merge: true)).then(
                  (value) {
            //  print('Created');
          });
        }
      });
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
  }

  List<Messages_Model> messages = [];
  Messages_Model? messages_model;
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
      messages = [];
      for (var element in event.docs) {
        messages.add(Messages_Model.fromjson(element.data()));
      }
      FirebaseFirestore.instance
          .collection('UsersCollection')
          .doc(sharedPreferences.getUserData()['user_id'])
          .collection('chats')
          .doc(receiverId)
          .set({'UnreadMasseges': 0}, SetOptions(merge: true)).then((value) {
        //  print('Created');
      });
      emit(SuccessGetMessagesState());
    });
  }

  GetMyChats_Model ? getMyChats_Model ;
  Future GetMyChats () {
    getMyChats_Model = null ;
    emit(LoadingGetMyChats());
    return FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc(sharedPreferences.getUserData()['user_id'])
        .collection('chats')
        .get()
        .then((querySnapshot) {
          getMyChats_Model = GetMyChats_Model.fromFireBase(querySnapshot.docs);
       GetMyChatsData();
      emit(SuccessGetMyChats());
    }).catchError((error) {
      emit(ErrorGetMyChats(error.toString()));
    });
  }

  void GetMyChatsData () {
    usersData = [] ;
    for ( int i  = 0 ; i < getMyChats_Model!.mychatsIds.length ; i++ ){
      GetUserProfile(getMyChats_Model!.mychatsIds[i]);
    }
  }

  void ChangeState() {
    emit(ChangeAnyState());
  }

  var imagepath ;

  Future getGallaryImage(BuildContext context) async {
    XFile? inputimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (inputimage != null) {
      imagepath = inputimage.path;
    }
  }

  void changeimage(BuildContext context) {
    getGallaryImage(context).then((value) {
      emit(ChangeAnyState());
    });
  }

  var selectedIndex = 0;

  void ChangePropertyCategory(int index) {
    selectedIndex = index;
    emit(ChangeAnyState());
  }

  bool isDark = ( sharedPreferences.getAppTheme('isDark') == null ) ? false : sharedPreferences.getAppTheme('isDark')! ;

  void ChangeAppTheme (){
    isDark = !isDark ;
    sharedPreferences.putAppTheme(key: 'isDark', value: isDark);
    myAppColorLight = (!isDark) ? const Color(0xff052d5d) : const Color(0xff728495) ;
    ScaffoldColorLight = (!isDark) ? Colors.grey[200]! : const Color(0xff263A47) ;
    primaryTextColorLight = (!isDark) ? Colors.black : Colors.white ;
    secondryTextColorLight = (!isDark) ? Colors.black45 : Colors.white54;
    containerBackgroundColor = (!isDark) ? Colors.white : const Color(0xff4A5B6A) ;
    emit(ChangeAnyState());
  }

  void initAppTheme () {
    myAppColorLight = (!isDark) ? const Color(0xff052d5d) : const Color(0xff728495) ;
    ScaffoldColorLight = (!isDark) ? Colors.grey[200]! : const Color(0xff263A47) ;
    primaryTextColorLight = (!isDark) ? Colors.black : Colors.white ;
    secondryTextColorLight = (!isDark) ? Colors.black45 : Colors.white54;
    containerBackgroundColor = (!isDark) ? Colors.white : const Color(0xff4A5B6A) ;
    emit(ChangeAnyState());
  }

}
