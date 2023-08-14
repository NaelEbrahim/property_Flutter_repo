// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
import 'package:university_project_property_app/Modules/Chatting/Message_Screen.dart';
import 'package:university_project_property_app/Remote/End_Points.dart';
import 'package:university_project_property_app/Shared/App_Bars.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RowComponent {
  late String text ;
  late IconData icon ;
  RowComponent(this.text, this.icon);
}


class Property_Details extends StatelessWidget {
  var information ;
  var ratecontroller = 0 ;

  Property_Details(this.information, {super.key});

  @override
  Widget build(BuildContext context) {
    List <RowComponent> rowItem = [
      RowComponent('${information.area.toString()} m\u00B2', Icons.area_chart_outlined),
      RowComponent('${information.numberofRooms.toString()} beds', Icons.bed_outlined),
      RowComponent('${information.numberofBaths.toString()} baths', Icons.bathtub_outlined),
    ];
    List <Widget> propertyImages = [] ;
    for ( String item in information.image ) {
      propertyImages.add(Image(
        image: NetworkImage(item),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ));
    }

    return BlocProvider(
      create: (context) => MyBloc(),
      child: BlocConsumer <MyBloc,Bloc_States>(
        listener: (context, state) {
          if ( state is SuccessBuyOrRentProperty ){
            Fluttertoast.showToast(
                msg: MyBloc.get(context).buyProperty_Model!.message.toString(),
                toastLength:
                Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 15,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Base_Screen()), (route) => false
            );
          }
          else if ( state is ErrorBuyOrRentProperty) {
            Fluttertoast.showToast(
                msg: 'Something went wrong,please try again later',
                toastLength:
                Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 6,
                backgroundColor:
                Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Base_Screen()), (route) => false
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ScaffoldColor,
            appBar: Property_Details_AppBar(context),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CarouselSlider(
                        items: propertyImages,
                        options: CarouselOptions(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: MediaQuery.of(context).size.height/2.5,
                          initialPage: 0,
                          reverse: false,
                          autoPlay: false,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.1,
                          autoPlayInterval: const Duration(seconds: 7),
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          autoPlayCurve: Curves.decelerate,
                          //enlargeCenterPage: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    reusableText(text: 'Dream House', fontsize: 15.0, fontWeight: FontWeight.bold),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: ListView.separated(
                        itemBuilder: (context, index) => BuildRow(context,rowItem[index]),
                        separatorBuilder: (context, index) => const SizedBox(width: 20.0),
                        itemCount: 3,
                        shrinkWrap: true ,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: (information.ownerimage.isNotEmpty)?NetworkImage(information.ownerimage[0]) : Image.asset('images/inisital_image.png').image,
                            ),
                          ),
                          GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                reusableText(text: 'Owner', fontsize: 11,fontColor: Colors.grey),
                                const SizedBox(height: 3.0),
                                reusableText(text: information.ownername.toString() , fontsize: 14,fontWeight: FontWeight.bold),
                                const SizedBox(height: 3.0),
                                RatingBarIndicator(
                                  itemBuilder: (context, index) => const Icon(Icons.star,color: Colors.amber,),
                                  itemCount: 5,
                                  unratedColor: Colors.grey,
                                  rating: double.parse(information.ownerRate),
                                  itemSize: 20.0,
                                )
                              ],
                            ),
                            onTap: (){
                              if ( sharedPreferences.getUserData()['user_id'] != information.ownerid.toString() ){
                                showDialog(
                                  context: context,
                                  builder: (context) => ShowRateDialog(context),
                                );
                              }
                            },
                          ),
                          const Spacer(),
                          if ( sharedPreferences.getUserData()['user_id'] != information.ownerid.toString() )
                           Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: myAppColor,
                                  child: IconButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Message_Screen({
                                              'ownerId' : information.ownerid.toString(),
                                              'ownername' : information.ownername,
                                              'ownerimage' : information.ownerimage,
                                              'ownerphone' : information.ownerphone.toString()
                                            })),
                                      );
                                    },
                                    icon : const Icon(Icons.chat_outlined),
                                    color: Colors.white,
                                    iconSize: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                CircleAvatar(
                                  backgroundColor: myAppColor,
                                  child: IconButton(
                                    onPressed: (){
                                      launchUrl(Uri(scheme: 'tel', path: '0${information.ownerphone.toString()}' ));
                                    },
                                    icon : const Icon(Icons.phone),
                                    color: Colors.white,
                                    iconSize: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    reusableText(text: 'Description :', fontsize: 15.0,fontWeight: FontWeight.bold),
                    const SizedBox(height: 5.0),
                    reusableText(
                        text: information.descreption.toString(),
                        fontsize: 13.0,
                        fontColor: Colors.grey,
                        maxLines: 4),
                    const SizedBox(height: 15.0),
                    reusableText(text: 'Location :', fontsize: 15.0,fontWeight: FontWeight.bold),
                    const SizedBox(height: 5.0),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          color : Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                              const Icon(Icons.location_on,color: Colors.black),
                              const SizedBox(width: 20.0),
                              reusableText(
                                text: '${information.namestate.toString().toUpperCase()} - ${information.address.toString().toUpperCase()}',
                                fontsize: 12,
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                              )
                            ]
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if ( sharedPreferences.getUserData()['user_id'] != information.ownerid.toString() )
                    ConditionalBuilder(
                        condition: state is! LoadingBuyOrRentProperty,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Container(
                            height: 55.0,
                            width: MediaQuery.of(context).size.width-100,
                            decoration: BoxDecoration(
                                color: myAppColor,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if ( sharedPreferences.getBankAccount() != null) {
                                      MyBloc.get(context).BuyAndRentProperty(
                                        Url: ( information.rent_or_sell == 'sell' ) ? BUYPROPERTY:RENTPROPERTY,
                                       data: {
                                      'number_account' : sharedPreferences.getBankAccount(),
                                      'id_property' : information.propertyId
                                    });
                                    }
                                    else {
                                      Fluttertoast.showToast(
                                          msg: 'You Do not Have Bank Account, please Add One',
                                          toastLength:
                                          Toast.LENGTH_LONG,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 6,
                                          backgroundColor:
                                          Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      reusableText(
                                          text: (information.rent_or_sell == 'sell' )?'\$${information.price.toString()}':
                                          '\$${information.monthlyRent.toString()}',
                                          fontsize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontColor: Colors.white
                                      ),
                                      const SizedBox(width: 10.0),
                                      reusableText(
                                          text: (information.rent_or_sell == 'sell' )?'/  Purchase Now':
                                          '/month - Book Now',
                                          fontsize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontColor: Colors.white
                                      )
                                    ],
                                  ),
                                )

                            ),
                          ),
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget BuildRow (BuildContext context , RowComponent item) => Container(
      height: 50.0,
      width: (MediaQuery.of(context).size.width-60)/3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color : Colors.white
      ),
      child : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon,color: myAppColor),
            const SizedBox(width: 10.0),
            reusableText(text: item.text, fontsize: 12.0)
          ],
        ),
      )
  );

  Widget ShowRateDialog (BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          reusableText(
              text: 'Rate Us',
              fontsize: 18.0,
              fontWeight: FontWeight.bold
          ),
          const SizedBox(width: 5.0),
          const Icon(Icons.verified_user_sharp,color: myAppColor),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RatingBar(
              minRating: 1,
              maxRating: 5,
              allowHalfRating: false,
              unratedColor: Colors.grey,
              onRatingUpdate: (rating){
                ratecontroller = rating.round();
              },
              ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  half: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                color: myAppColor,
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: reusableTextButton(
                buttontext: 'Submit',
                  context: context,
                 fontSize: 18.0,
                 textColor: Colors.white,
                  function: (){
                    MyBloc.get(context).UserRate({
                      'id_owner' : information.ownerid,
                      'rateValue' : ratecontroller,
                    });
                     Navigator.pop(context);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

