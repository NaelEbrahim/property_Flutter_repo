class Messages_Model {
  String? senderId;

  String? receiverId;

  String? datetime;

  String? houtWithminute;

  String? text;

  Messages_Model({
      required this.senderId,
      required this.receiverId,
      required this.datetime,
      required this.houtWithminute,
      required this.text
      });

  Messages_Model.fromjson ( json ){//Map < String , dynamic > json
    senderId = json['senderId'] ;
    receiverId = json['receiverId'] ;
    datetime = json['datetime'] ;
    houtWithminute = json['houtWithminute'];
    text = json['text'] ;
  }

  Map < String , dynamic > tomap (){
    return {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'datetime' : datetime,
      'houtWithminute' : houtWithminute,
      'text' : text
    };
}
}
