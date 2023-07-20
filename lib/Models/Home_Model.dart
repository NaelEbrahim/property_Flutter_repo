// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, camel_case_types, non_constant_identifier_names, file_names

class Home_Model {
  List<PropertyModel> propertylist = [];

  Home_Model.fromjson(List<dynamic> json) {
    if (json != null) {
      for (var element in json) {
        propertylist.add(PropertyModel.fromjson(element['property']));
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
  var image;
  var descreption;
  var price;

  PropertyModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    typeofproperty = json['typeofproperty'];
    rent_or_sell = json['rent_or_sell'];
    address = json['address'];
    area = json['area'];
    numberofRooms = json['numberofRooms'];
    image = json['image'];
    descreption = json['descreption'];
    price = json['price'];
  }
}
