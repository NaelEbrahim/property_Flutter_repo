// ignore_for_file: camel_case_types, file_names, must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import '../Shared/Constant.dart';
import 'Add_Property.dart';

class Favourite_Screen extends StatelessWidget {
  Favourite_Screen({Key? key}) : super(key: key);

  bool sell = true ;

  var numberOfRoomcontroller = TextEditingController();

  int numberOfbathroom = 3 ;

  int numberOfbedroom = 2 ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc , Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColor,
            appBar: AppBar(
              backgroundColor: myAppColor,
              leading: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.arrow_back,color: Colors.white),
              ),
              title: reusableText(
                  text: 'Filter',
                  fontsize: 19,
                  fontColor: Colors.white,
                fontWeight: FontWeight.bold
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                      text: 'Category :',
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            reusableText(text: 'Bedroom', fontsize: 15.0,fontColor: Colors.grey,fontWeight: FontWeight.bold),
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
                                        if ( numberOfbedroom > 1) {
                                          numberOfbedroom --;
                                          cubit.ChangeState();
                                        }
                                      },
                                      alignment: Alignment.topCenter,
                                      icon: const Icon(Icons.minimize,color: Colors.black)
                                  ),
                                  const Spacer(),
                                  reusableText(
                                      text: numberOfbedroom.toString(),
                                      fontsize: 16
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: (){
                                        if ( numberOfbedroom < 10 ) {
                                          numberOfbedroom ++;
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
                  )

                ],
              ),
            ),
          );
        },
      ) ,
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
