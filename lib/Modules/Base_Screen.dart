// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Favourite_Screen.dart';
import 'package:university_project_property_app/Shared/App_Bars.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'Filter_Screen.dart';
import 'Home_Screen.dart';
import 'Profile_Screen.dart';

class Base_Screen extends StatelessWidget {
  Base_Screen({Key? key}) : super(key: key);

  List <Widget> screens = [
    Home_Screen(),
    Filter_Screen(),
    const Favourite_Screen(),
    const Profile_Screen()
  ] ;

  List <AppBar> appbars = [
    Home_AppBar(),
    Filter_AppBar(),
    Favourite_AppBar(),
    Profile_AppBar()
  ] ;

  var CurrentBottomNavIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc,Bloc_States> (
        listener: (context, state) => (){},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColor,
            appBar: appbars[CurrentBottomNavIndex],
            body: screens[CurrentBottomNavIndex],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: myAppColor
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    child: BottomNavigationBar(
                      currentIndex: CurrentBottomNavIndex,
                      onTap: (int index ) {
                        CurrentBottomNavIndex = index ;
                        cubit.ChangeState();
                      },
                      selectedItemColor: Colors.white,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(icon: Icon(Icons.house_outlined),label: 'Home'),
                        BottomNavigationBarItem(icon: Icon(Icons.filter_list),label: 'Filter'),
                        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'Favorite'),
                        BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: 'Profile'),
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
