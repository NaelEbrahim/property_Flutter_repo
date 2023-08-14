// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:university_project_property_app/Modules/Search_Screen.dart';
import 'package:university_project_property_app/Modules/User_Profile/UpdateProfile_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

AppBar Home_AppBar () => AppBar(
  backgroundColor: myAppColor,
  bottomOpacity: 0.0,
  elevation: 0.0,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      reusableText(
        text: 'Current Location',
        fontsize: 14,
        fontWeight: FontWeight.w200,
        fontColor: Colors.white
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.blue,
          ),
          reusableText(text: 'Syria - Damascus', fontsize: 16,fontColor: Colors.white),
        ],
      ),
    ],
  ),
  actions:  [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: (){
            Navigator.push(baseScreenContext!, MaterialPageRoute(builder: (context) => Search_Screen()));
              } ,
          icon: const Icon(Icons.search,size: 27.0),
      )
    ),
  ],
  leading: IconButton(
    onPressed: (){
      Scaffold.of(baseScreenContext!).openDrawer();
    },
    icon: const Icon(Icons.menu, color: Colors.white),
  )
);

AppBar Profile_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Scaffold.of(baseScreenContext!).openDrawer();
    },
    icon: const Icon(Icons.menu, color: Colors.white),
  ),
  title: reusableText(
      text: 'Profile',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
  actions: [
    IconButton(onPressed: (){
      Navigator.push(baseScreenContext!, MaterialPageRoute(builder: (context) => UpdateProfile_Screen()));
    }, icon: const Icon(Icons.edit))
  ],
);

AppBar Filter_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Scaffold.of(baseScreenContext!).openDrawer();
    },
    icon: const Icon(Icons.menu, color: Colors.white),
  ),
  title: reusableText(
      text: 'Filter',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Favourite_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Scaffold.of(baseScreenContext!).openDrawer();
    },
    icon: const Icon(Icons.menu, color: Colors.white),
  ),
  title: reusableText(
      text: 'Favourite',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Search_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(searchScreenContext!);
    },
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Search',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Property_Details_AppBar (BuildContext context) => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Property Details',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Add_Property_AppBar () => AppBar(
  backgroundColor: myAppColor,
  elevation: 0.0,
  leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed:(){}
  ),
  title: reusableText(
      text: 'Add Property',
      fontsize: 20,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
) ;

AppBar Picked_Images_AppBar (BuildContext context) => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Property Images',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);