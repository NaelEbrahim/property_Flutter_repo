// ignore_for_file: camel_case_types, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/App_Bars.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class Search_Screen extends StatelessWidget {
  Search_Screen({super.key});

  var searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc , Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state) {
          searchScreenContext = context ;
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColor,
            appBar: Search_AppBar(),
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: reusableTextField(
                                hintText: 'Search For Dream House',
                                prefixIcon: const Icon(Icons.search,color: Colors.grey,size: 20),
                                controller: searchcontroller
                            ),
                          ),
                          Container(
                            color: myAppColor,
                            height: 62.0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                cubit.Search({
                                  'name' : searchcontroller.text
                                });
                              },
                              icon: const Icon(Icons.search,color: Colors.white,size: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 100.0),
                    Center(child: reusableText(
                        text: 'You Can Search With : \n1 - Type : house - land - market\n2 - Owner Name : "rami hussin"\n3 - Contract : sell - rent',
                        fontColor: Colors.black38,
                        fontWeight: FontWeight.w600,
                        fontsize: 15.0
                    ))
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}