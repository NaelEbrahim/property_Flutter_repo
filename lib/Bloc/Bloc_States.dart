// ignore_for_file: camel_case_types, file_names

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Bloc_States {}

class Initial_State extends Bloc_States {}

//******************* LOGIN STATES *****************//
class LoadingLoginState extends Bloc_States {}

class SuccessLoginState extends Bloc_States {}

class ErrorLoginState extends Bloc_States {
  String ? error ;
  ErrorLoginState(this.error);
}

//******************* SIGNUP STATES *****************//
class LoadingSignupState extends Bloc_States {}

class SuccessSignupState extends Bloc_States {}

class ErrorSignupState extends Bloc_States {}

//******************* CHATTING STATES *****************//
class SuccessSendMessageState extends Bloc_States {}

class ErrorSendMessageState extends Bloc_States {}

class SuccessGetMessagesState extends Bloc_States {}

class SuccessReceiveMessagesState extends Bloc_States {}


//******************* OTHER STATES *****************//
class ChangeEyeIcon extends Bloc_States {}

class ChangeAnyState extends Bloc_States {}
