// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

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

//******************* HOME SLIDER STATES *****************//
class LoadingGetHomeSlider extends Bloc_States {}

class SuccessGetHomeSlider extends Bloc_States {}

class ErrorGetHomeSlider extends Bloc_States {
  String error ;

  ErrorGetHomeSlider(this.error);
}

//******************* USER RATE STATES *****************//
class LoadingUserRate extends Bloc_States {}

class SuccessUserRate extends Bloc_States {}

class ErrorUserRate extends Bloc_States {
  String error ;

  ErrorUserRate(this.error);
}

//******************* UPDATE USER PROFILE STATES *****************//
class LoadingUpdateUserProfile extends Bloc_States {}

class SuccessUpdateUserProfile extends Bloc_States {}

class ErrorUpdateUserProfile extends Bloc_States {
  String error ;

  ErrorUpdateUserProfile(this.error);
}

//******************* SEARCH PROPERTY STATES *****************//
class LoadingSearchProperty extends Bloc_States {}

class SuccessSearchProperty extends Bloc_States {}

class ErrorSearchProperty extends Bloc_States {
  String ? error ;

  ErrorSearchProperty(this.error);
}

//******************* FILTER PROPERTY STATES *****************//
class LoadingFilterProperty extends Bloc_States {}

class SuccessFilterProperty extends Bloc_States {}

class ErrorFilterProperty extends Bloc_States {
  String ? error ;

  ErrorFilterProperty(this.error);
}

//******************* User LOGOUT STATES *****************//
class LoadingUserLogout extends Bloc_States {}

class SuccessUserLogout extends Bloc_States {}

class ErrorUserLogout extends Bloc_States {
  String ? error ;

  ErrorUserLogout(this.error);
}

//******************* ADD TO FAVORITE STATES *****************//
class LoadingAddToFavorite extends Bloc_States {}

class SuccessAddToFavorite extends Bloc_States {}

class ErrorAddToFavorite extends Bloc_States {
  String ? error ;

  ErrorAddToFavorite(this.error);
}

//******************* GET USER PROFILE STATES *****************//
class LoadingGetUserProfile extends Bloc_States {}

class SuccessGetUserProfile extends Bloc_States {}

class ErrorGetUserProfile extends Bloc_States {
  String ? error ;

  ErrorGetUserProfile(this.error);
}

//******************* BUY & RENT PROPERTY STATES *****************//
class LoadingBuyOrRentProperty extends Bloc_States {}

class SuccessBuyOrRentProperty extends Bloc_States {}

class ErrorBuyOrRentProperty extends Bloc_States {
  String ? error ;

  ErrorBuyOrRentProperty(this.error);
}

//******************* GET MY BANK ACCOUNT STATES *****************//
class LoadingGetMyBankAccount extends Bloc_States {}

class SuccessGetMyBankAccount extends Bloc_States {}

class ErrorGetMyBankAccount extends Bloc_States {
  String ? error ;

  ErrorGetMyBankAccount(this.error);
}

//******************* GET MY CHATS STATES *****************//
class LoadingGetMyChats extends Bloc_States {}

class SuccessGetMyChats extends Bloc_States {}

class ErrorGetMyChats extends Bloc_States {
  String ? error ;

  ErrorGetMyChats(this.error);
}

//******************* OTHER STATES *****************//
class ChangeEyeIcon extends Bloc_States {}

class ChangeAnyState extends Bloc_States {}
