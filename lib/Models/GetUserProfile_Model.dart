// ignore_for_file: prefer_typing_uninitialized_variables, file_names, camel_case_types

class GetUserProfile_Model {
  var id ;
  var name ;
  var image ;
  var phone ;
  var unreadMessages ;

  GetUserProfile_Model.fromjson (Map <String,dynamic> json , unreadmessages ){
    id = json['id'] ;
    name = json['name'] ;
    image = json['image'] ;
    phone = json['phone'] ;
    unreadMessages = unreadmessages ;
  }
}