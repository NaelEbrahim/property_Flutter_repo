// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:image_picker/image_picker.dart';

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

//******************* ADD PROPERTY STATES *****************//
class LoadingAddProperty extends Bloc_States {}

class SuccessAddProperty extends Bloc_States {}

class ErrorAddProperty extends Bloc_States {
  String ? error ;

  ErrorAddProperty(this.error);
}

//******************* GET ALL PROPERTY STATES *****************//
class LoadingGetAllProperty extends Bloc_States {}

class SuccessGetAllProperty extends Bloc_States {}

class ErrorGetAllProperty extends Bloc_States {
  String ? error ;

  ErrorGetAllProperty(this.error);
}

//******************* SEARCH PROPERTY STATES *****************//
class LoadingSearchProperty extends Bloc_States {}

class SuccessSearchProperty extends Bloc_States {}

class ErrorSearchProperty extends Bloc_States {
  String ? error ;

  ErrorSearchProperty(this.error);
}

//******************* OTHER STATES *****************//
class ChangeEyeIcon extends Bloc_States {}

class ChangeAnyState extends Bloc_States {}
