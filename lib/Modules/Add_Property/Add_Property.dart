// ignore_for_file: camel_case_types, non_constant_identifier_names, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Add_Property/Picked_Images.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';
import '../../Shared/App_Bars.dart';

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

  bool sell = true;

  String type = 'house';
  String sell_rent = 'sell' ;
  var numberOfRoomcontroller = TextEditingController();
  var areacontroller = TextEditingController();
  var namePropertycontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var locationcontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();


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
            appBar: Add_Property_AppBar(),
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
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    fontColor: ( sell ) ? Colors.white : Colors.black
                                ),
                              ),
                            ),
                            onTap: (){
                              if ( !sell ) {
                                sell = !sell;
                                sell_rent = (sell) ? 'sell' : 'rent' ;
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
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    fontColor: ( !sell ) ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            onTap: (){
                              if ( sell ) {
                                sell = !sell;
                                sell_rent = (sell) ? 'sell' : 'rent' ;
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
                            controller: areacontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Name :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Property Title',
                            prefixIcon: const Icon(Icons.title),
                            raduis: 20.0,
                            controller: namePropertycontroller
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
                            controller: pricecontroller
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
                            controller: locationcontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Description :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        reusableTextField(
                            hintText: 'Description',
                            raduis: 20.0,
                            prefixIcon: const Icon(Icons.info),
                            controller: descriptioncontroller
                        ),
                        const SizedBox(height: 20.0),
                        reusableText(
                            text: 'Property Images :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 10.0),
                        Row(children:[
                          Container(
                            height: 70.0,
                            width:( MediaQuery.of(context).size.width/2)-30,
                            decoration: BoxDecoration(
                              color: myAppColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: reusableTextButton(
                              context: context,
                              buttontext: 'Select Images',
                              textColor: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              function: (){
                                cubit.AddToSelectedImages();
                              },
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Picked_Images()
                                  ));
                              },
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 80.0,
                              width: (MediaQuery.of(context).size.width/2)-60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  const Align(
                                    alignment: AlignmentDirectional.center,
                                      child: Icon(Icons.photo_library,size: 35.0,color: myAppColor)),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.7),
                                    child: reusableText(
                                        text: 'Images',
                                        fontsize: 10.0,
                                        fontColor: Colors.white,
                                        align: TextAlign.center
                                    ))
                                ],
                              )
                            ),
                          )
                        ]),
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
                                function: (){
                                  xFilesToBase64(FileToimages).then((value){
                                  cubit.AddProperty(
                                        data: {
                                         'typeofproperty' : type,
                                         'rent_or_sell' : sell_rent,
                                         'address' : locationcontroller.text,
                                         'numberofRooms' : numberOfRoomcontroller.text,
                                         'descreption' : descriptioncontroller.text,
                                         'nameState' : 'damasucs',
                                         'area' : areacontroller.text,
                                         'price' : pricecontroller.text,
                                         'image[]' : 'base64Strings',
                                        },
                                        header: '8|D4K8TbYyaMqXT3RbB2USDmMJxT1L4UMOHpGOhjSd'
                                  );
                                  });
                                },
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
        cubit.ChangePropertyCategory(index);
        type = category_list[cubit.selectedIndex].title_type ;
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
