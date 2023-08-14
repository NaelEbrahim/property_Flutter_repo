// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, camel_case_types, non_constant_identifier_names, file_names

class Search_Model {
  List <PropertySearchModel> propertylist = [];

  Search_Model.fromjson( json ) {
    if (json != null) {
      for (var element in json) {
        Map < String , dynamic > data = {
          'name_state' : element['state'],
          'owner_name' : element['owner name'] ,
          'owner_image' : element['owner image'],
          'owner_phone' : element['owner phone'],
          'owner_rate' : element['rate']
        };
        propertylist.add(PropertySearchModel.fromjson( data , element['his property']));
      }
    }
  }
}

class PropertySearchModel {
  var ownerid;
  var typeofproperty;
  var rent_or_sell;
  var address;
  var area;
  var numberofRooms;
  var numberofBaths ;
  List <String> image = [] ;
  var descreption;
  var price;
  var monthlyRent ;
  var ownername ;
  List <String> ownerimage = [] ;
  var ownerphone ;
  var namestate ;
  var ownerRate ;

  PropertySearchModel.fromjson( Map <String , dynamic > data , Map<String, dynamic> json) {
    ownername = data['owner_name'] ;
    namestate = data['name_state'];
    ownerphone = data['owner_phone'] ;
    ownerid = json['users_id'];
    ownerRate = data['owner_rate'] ;
    typeofproperty = json['typeofproperty'];
    rent_or_sell = json['rent_or_sell'];
    address = json['address'];
    area = json['area'];
    numberofRooms = json['numberofRooms'];
    numberofBaths = json['bathRoom'] ;
    descreption = json['descreption'];
    price = json['price'];
    monthlyRent = json['monthlyRent'];
    if ( data['owner_image'] != null ){
      for (String element in data['owner_image']){
        ownerimage.add(element) ;
      }
    }
    if ( json['image'] != null ){
      for (String element in json['image']){
        image.add(element) ;
      }
    }
  }
}
