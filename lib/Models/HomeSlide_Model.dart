// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, file_names

class HomeSlider_Model {
  List <PropertyData> sellProperty = [] ;

  HomeSlider_Model.formjson( Map <String , dynamic > json ){
      if (json['property sell'] != null ) {
        for (var element in json['property sell']) {
          sellProperty.add(PropertyData.fromjson(element));
        }
      }
    if ( json['property rent'] != null ) {
      for (var element in json['property rent']) {
        sellProperty.add(PropertyData.fromjson(element));
      }
    }
  }
}

class PropertyData {
  var id ;
  var typeofproperty ;
  var rent_or_sell ;
  var address ;
  var area ;
  var numberofRooms ;
  var bathRoom ;
  var descreption ;
  var price ;
  var monthlyRent ;
  var price_square_meter ;
  List <String> image = [] ;

  PropertyData.fromjson ( Map <String , dynamic> json ) {
    id = json ['id'] ;
    typeofproperty = json ['typeofproperty'] ;
    rent_or_sell = json ['rent_or_sell'] ;
    address = json ['address'] ;
    area = json ['area'] ;
    numberofRooms = json ['numberofRooms'] ;
    bathRoom = json ['bathRoom'] ;
    descreption = json ['descreption'] ;
    price = json ['price'] ;
    monthlyRent = json['monthlyRent'] ;
    price_square_meter = json ['price_square_meter'] ;
    if ( json['image'].isNotEmpty ){
      json['image'].forEach((element){
        image.add(element);
      });
    }
  }
}