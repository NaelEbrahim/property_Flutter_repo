// ignore_for_file: camel_case_types, file_names, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Filter/Filter_Result.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Resources.dart';
import '../../Shared/Constant.dart';
import '../Add_Property/Add_Property.dart';

class Filter_Screen extends StatelessWidget {
  Filter_Screen({Key? key}) : super(key: key);

  bool sell = true ;

  var areacontroller = TextEditingController();

  var locationcontroller = TextEditingController();

  int numberOfbathroom = 3 ;

  int numberOfroom = 2 ;

  String type = 'house' ;

  String sell_rent = 'sell' ;


  double minprice = 20000.0 ;

  double maxprice = 60000.0 ;

  double minrent = 1000.0 ;

  double maxrent = 6000.0 ;

  SfRangeValues sell_values = const SfRangeValues(20000.0, 60000.0);

  SfRangeValues rent_values = const SfRangeValues(1000.0, 6000.0);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer <MyBloc , Bloc_States>(
      listener: (context, state) => (){},
      builder: (context, state) {
        baseScreenContext = context ;
        var cubit = MyBloc.get(context);
        return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                      text: 'Contract :',
                      fontsize: 15.0,
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
                      textInputType: TextInputType.number,
                      controller: areacontroller
                  ),
                  const SizedBox(height: 20.0),
                  reusableText(
                      text: 'Property Location :',
                      fontsize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.grey,
                  ),
                  const SizedBox(height: 10.0),
                  reusableTextField(
                      hintText: 'Write Location',
                      prefixIcon: const Icon(Icons.location_on),
                      raduis: 20.0,
                      controller: locationcontroller
                  ),
                  const SizedBox(height: 20.0),
                  if ( sell_rent == 'sell')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                          text: 'Property Price :',
                          fontsize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.grey
                      ),
                      const SizedBox(height: 50.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                                tooltipBackgroundColor: ScaffoldColor,
                                tooltipTextStyle: const TextStyle(
                                    color: myAppColor,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            child: SfRangeSlider(
                              min: 10000.0,
                              max: 100000.0,
                              values: sell_values,
                              activeColor: myAppColor,
                              stepSize: 1000.0,
                              inactiveColor: myAppColor.withOpacity(0.3),
                              shouldAlwaysShowTooltip: true,
                              onChanged: (value) {
                                maxprice = value.end ;
                                minprice = value.start ;
                                sell_values = value ;
                                cubit.ChangeState();
                              },
                            )
                        ),
                      ),
                    ],
                  ),
                  if ( sell_rent == 'rent')
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText(
                            text: 'Property Rent :',
                            fontsize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.grey
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width-40,
                          child: SfRangeSliderTheme(
                              data: SfRangeSliderThemeData(
                                  tooltipBackgroundColor: ScaffoldColor,
                                  tooltipTextStyle: const TextStyle(
                                      color: myAppColor,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              child: SfRangeSlider(
                                min: 200.0,
                                max: 10000.0,
                                values: rent_values,
                                activeColor: myAppColor,
                                stepSize: 100.0,
                                inactiveColor: myAppColor.withOpacity(0.3),
                                shouldAlwaysShowTooltip: true,
                                onChanged: (value) {
                                  maxrent = value.end ;
                                  minrent = value.start ;
                                rent_values = value ;
                                  cubit.ChangeState();
                                },
                              )
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            reusableText(text: 'Room', fontsize: 15.0,fontColor: Colors.grey,fontWeight: FontWeight.bold),
                            const SizedBox(height: 5.0),
                            Container(
                              height: 55.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row (
                                children: [
                                  IconButton(
                                      iconSize: 20.0,
                                      onPressed: (){
                                        if ( numberOfroom > 1) {
                                          numberOfroom --;
                                          cubit.ChangeState();
                                        }
                                      },
                                      alignment: Alignment.topCenter,
                                      icon: const Icon(Icons.minimize,color: Colors.black)
                                  ),
                                  const Spacer(),
                                  reusableText(
                                      text: numberOfroom.toString(),
                                      fontsize: 16
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: (){
                                        if ( numberOfroom < 10 ) {
                                          numberOfroom ++;
                                          cubit.ChangeState();
                                        }
                                      },
                                      icon: const Icon(Icons.add,color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40.0),
                      Expanded(
                        child: Column(
                          children: [
                            reusableText(text: 'Bathroom', fontsize: 15.0,fontColor: Colors.grey,fontWeight: FontWeight.bold),
                            const SizedBox(height: 5.0),
                            Container(
                              height: 55.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      iconSize: 20.0,
                                      alignment: Alignment.topCenter,
                                      onPressed: (){
                                        if ( numberOfbathroom > 1) {
                                          numberOfbathroom --;
                                          cubit.ChangeState();
                                        }
                                      },
                                      icon: const Icon(Icons.minimize,color: Colors.black)
                                  ),
                                  const Spacer(),
                                  reusableText(
                                      text: numberOfbathroom.toString(),
                                      fontsize: 16
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: (){
                                        if ( numberOfbathroom < 6 ) {
                                          numberOfbathroom ++;
                                          cubit.ChangeState();
                                        }
                                      },
                                      icon: const Icon(Icons.add,color: Colors.black)
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: myAppColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: reusableTextButton(
                          context: context,
                          buttontext: 'Search',
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600,
                          function: (){
                            if (sell_rent == 'sell') {
                              cubit.filter({
                              'typeofproperty' : type ,
                              'rent_or_sell' : sell_rent ,
                              'state' : 'damascus' ,
                              'location' : locationcontroller.text ,
                              'area' : areacontroller.text ,
                              'num_of_rooms' : numberOfroom ,
                              'bathRoom' : numberOfbathroom ,
                              'minprice' : minprice.round() ,
                              'maxprice' : maxprice.round() ,
                            }).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Filter_Result(cubit.filter_model!.propertylist)));
                            });
                            }
                            if ( sell_rent == 'rent') {
                              cubit.filter({
                              'typeofproperty' : type ,
                              'rent_or_sell' : sell_rent ,
                              'state' : 'damascus' ,
                              'location' : locationcontroller.text ,
                              'area' : areacontroller.text ,
                              'num_of_rooms' : numberOfroom ,
                              'bathRoom' : numberOfbathroom ,
                              'minRent' : minrent.round(),
                              'maxRent' : maxrent.round(),
                            }).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Filter_Result(cubit.filter_model!.propertylist)));
                            });
                            }
                          }
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
      },
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