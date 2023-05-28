// ignore_for_file: camel_case_types, non_constant_identifier_names

class Login_Model {
  User_Data ? user_data ;
  String ? token ;

  Login_Model.fromjson(Map<String,dynamic>json){
    token = json['token'];
    user_data = ( json['token'] == null ) ? null : User_Data.fromjson(json['user']) ;
  }
}

class User_Data {
  int ? id ;
  String ? name ;
  String ? email ;
  String ? phone ;
  String ? image ;
  int ? age ;
  String ? gender ;
  String ? information_about ;

  User_Data.fromjson ( Map <String , dynamic> json ){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    information_about = json['information_about'];
  }
}
