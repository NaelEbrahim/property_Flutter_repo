// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, file_names

class ShowFavorite_Model {

  List <PropertyFavorite> favorites = [] ;

  ShowFavorite_Model.fromjson ( json ){
    if (json != null){
      for ( var element in json ) {
        Map <String , dynamic> data = {
          'name_state' : element['state'],
          'owner_name' : element['owner name'] ,
          'owner_image' : element['owner image'],
          'owner_phone' : element['owner phone'],
          'owner_rate' : element['rate']
        };
        favorites.add(PropertyFavorite.fromjson( element['property'], data ));
      }
  }
  }
}

class PropertyFavorite {
  var id ;
  var ownerid ;
  var typeofproperty ;
  var rent_or_sell ;
  var address ;
  var area ;
  var numberofRooms ;
  var numberofBaths ;
  var descreption ;
  var price ;
  var monthlyRent ;
  var state ;
  List <String> image = [];
  var ownername ;
  List <String> ownerimage = [] ;
  var ownerphone ;
  var namestate ;
  var ownerRate ;


  PropertyFavorite.fromjson( Map <String,dynamic> json , Map <String,dynamic> data ){
    ownername = data['owner_name'] ;
    namestate = data['name_state'] ;
    ownerRate = data['owner_rate'] ;
    ownerphone = data['owner_phone'] ;
    ownerid = json['users_id'] ;
    id = json['id'] ;
    typeofproperty = json['typeofproperty'] ;
    rent_or_sell = json['rent_or_sell'] ;
    address = json['address'] ;
    area = json['area'] ;
    numberofRooms = json['numberofRooms'] ;
    numberofBaths = json['bathRoom'] ;
    descreption = json['descreption'] ;
    price = json['price'] ;
    monthlyRent = json['monthlyRent'] ;
    if( json['image'].isNotEmpty ){
      json['image'].forEach((element){
        image.add(element);
      });
    }
    if ( data['owner_image'].isNotEmpty ){
      data['owner_image'].forEach((item){
        ownerimage.add(item);
      });
    }
  }

}