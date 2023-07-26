// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, camel_case_types, non_constant_identifier_names, file_names

class Home_Model {
  List<PropertyModel> propertylist = [];

  Home_Model.fromjson( List <dynamic> json ) {
    if (json != null) {
      for (var element in json) {
        Map < String , dynamic > data = {
          'name_state' : element['state'],
          'owner_name' : element['owner name'] ,
          'owner_image' : element['owner image'],
          'owner_phone' : element['owner phone'],
        };
        propertylist.add(PropertyModel.fromjson( data , element['property'] ));
      }
    }
  }
}

class PropertyModel {
  var id;
  var typeofproperty;
  var rent_or_sell;
  var address;
  var area;
  var numberofRooms;
  var numberofBaths ;
  var image;
  var descreption;
  var price;
  var ownername ;
  var ownerimage ;
  var ownerphone ;
  var namestate ;

  PropertyModel.fromjson( Map <String , dynamic > data , Map<String, dynamic> json ){
    ownername = data['owner_name'] ;
    ownerimage = ( data['owner_image'] == null ) ? null : data['owner_image'] ;
    namestate = data['name_state'] ;
    ownerphone = data['owner_phone'] ;
    id = json['id'];
    typeofproperty = json['typeofproperty'];
    rent_or_sell = json['rent_or_sell'];
    address = json['address'];
    area = json['area'];
    numberofRooms = json['numberofRooms'];
    numberofBaths = json['bathRoom'] ;
    image = json['image'];
    descreption = json['descreption'];
    price = json['price'];
  }
}
