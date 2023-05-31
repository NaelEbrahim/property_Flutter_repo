// ignore_for_file: camel_case_types, non_constant_identifier_names, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class property_category {
  String title_type ;
  IconData icon_type ;
  property_category(this.title_type, this.icon_type);
}

List <property_category> category_list = [
  property_category('House', Icons.house),
  property_category('Land', Icons.landscape),
  property_category('Market', Icons.food_bank_outlined),
];

class Add_Property extends StatelessWidget {
  Add_Property({Key? key}) : super(key: key);

  bool sell = true ;

  var numberOfRoomcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc,Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColor,
            appBar: AppBar(
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
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText(
                            text: 'I Want to :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        Row(children: [
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: (MediaQuery.of(context).size.width/2)-30,
                              decoration: BoxDecoration(
                                  color: ( sell ) ? myAppColor : Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: reusableText(
                                    text: "Sell",
                                    fontsize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontColor: ( sell ) ? Colors.white : Colors.black
                                ),
                              ),
                            ),
                            onTap: (){
                              if ( !sell ) {
                                sell = !sell;
                                cubit.ChangeState();
                              }
                            },
                          ),
                          const Spacer() ,
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: (MediaQuery.of(context).size.width/2)-30,
                              decoration: BoxDecoration(
                                  color: ( !sell ) ? myAppColor : Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: reusableText(
                                    text: "Rent",
                                    fontsize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontColor: ( !sell ) ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            onTap: (){
                              if ( sell ) {
                                sell = !sell;
                                cubit.ChangeState();
                              }
                            },
                          ),

                        ]),
                        const SizedBox(height: 30.0),
                        reusableText(
                            text: 'Property Type :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 100.0,
                          child: ListView.separated(
                            shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => BuildCategory(category_list[index], context,index),
                              separatorBuilder: (context, index) => const SizedBox(width: 20.0),
                              itemCount: 3
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Area :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Area in Square Meter',
                            prefixIcon: const Icon(Icons.stacked_line_chart),
                            raduis: 20.0,
                            controller: numberOfRoomcontroller
                        ),
                        if ( cubit.selectedIndex == 0)
                        const SizedBox(height: 20.0),
                        if ( cubit.selectedIndex == 0)
                          reusableText(
                              text: 'Property Rooms :',
                              fontsize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.grey
                          ),
                        if ( cubit.selectedIndex == 0)
                        const SizedBox(height: 10.0),
                        if(cubit.selectedIndex == 0)
                        reusableTextField(
                            hintText: 'Number Of Rooms',
                            textInputType: TextInputType.phone,
                            raduis: 20.0,
                            prefixIcon: const Icon(Icons.meeting_room_outlined),
                            controller: numberOfRoomcontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Price :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Price',
                            raduis: 20.0,
                            textInputType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.monetization_on),
                            controller: numberOfRoomcontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Location :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Location',
                            raduis: 20.0,
                            prefixIcon: const Icon(Icons.location_on),
                            controller: numberOfRoomcontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Info :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Info',
                            raduis: 20.0,
                            prefixIcon: const Icon(Icons.info),
                            controller: numberOfRoomcontroller
                        ),
                        const SizedBox(height: 30.0),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 60.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: myAppColor,
                                borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: reusableTextButton(
                                context: context,
                                buttontext: 'Add',
                                textColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                function: (){},
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),
          );
        }
      ),
    );
  }
  Widget BuildCategory ( property_category item , BuildContext context , index ) {
    var cubit = MyBloc.get(context);
    return GestureDetector(
      onTap: (){
        MyBloc.get(context).ChangePropertyCategory(index);
      },
      child: Container(
          height: 100.0,
          width: (MediaQuery.of(context).size.width/3)-30,
          decoration: BoxDecoration(
              color: (cubit.selectedIndex == index) ? myAppColor : Colors.white,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  item.icon_type,
                  color: (cubit.selectedIndex == index) ? Colors.white : myAppColor,
                  size: 30
              ),
              reusableText(
                  text: item.title_type,
                  fontColor: (cubit.selectedIndex == index) ? Colors.white : myAppColor,
                  fontsize: 13
              ),
            ],
          )
      ),
    );
    }
}
