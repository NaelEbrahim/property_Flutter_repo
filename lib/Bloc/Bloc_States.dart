// ignore_for_file: camel_case_types, file_names

abstract class Bloc_States {}

class Initial_State extends Bloc_States {}

//******************* LOGIN STATES *****************//
class LoadingLoginState extends Bloc_States {}

class SuccessLoginState extends Bloc_States {}

class ErrorLoginState extends Bloc_States {
  String ? error ;
  ErrorLoginState(this.error);
}

//******************* LOGIN STATES *****************//
class LoadingSignupState extends Bloc_States {}

class SuccessSignupState extends Bloc_States {}

class ErrorSignupState extends Bloc_States {}

//******************* OTHER STATES *****************//
class ChangeEyeIcon extends Bloc_States {}

class ChangeDropdown extends Bloc_States {}