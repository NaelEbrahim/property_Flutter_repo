// ignore_for_file: camel_case_types, file_names, must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class Home_Screen extends StatelessWidget {
   Home_Screen({Key? key}) : super(key: key);

   var searchcontroller = TextEditingController();

  List img = [
    'images/2.jpg',
    'images/2.jpg',
    'images/2.jpg',
  ];

  @override
  Widget build(BuildContext context){
      return BlocConsumer<MyBloc , Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  reusableTextField(
                    hintText: 'Search For Dream House',
                    raduis: 15.0,
                    fontColor: Colors.black,
                    hintstyle: const TextStyle(fontWeight: FontWeight.w200),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    controller: searchcontroller,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0) ,
                      child: CarouselSlider.builder(
                        itemCount: img.length,
                        itemBuilder: (context, index, l) {
                          return Image.asset(
                            width: MediaQuery.of(context).size.width - 20,
                            'images/2.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                        options: CarouselOptions(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 170.0,
                          initialPage: 0,
                          reverse: false,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.1,
                          autoPlayInterval: const Duration(seconds: 7),
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          autoPlayCurve: Curves.decelerate,
                          //enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => card(204500, 'Syria - Damascus - Al Amin', 4,3,150,context),
                    separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                    itemCount: 5,
                  ),
                ],
              ),
            ),
          );
        },
      );
  }

   card(int prize, String loc, int bedcount,int bathcount,int area,BuildContext context) {
     return Container(
       clipBehavior: Clip.antiAliasWithSaveLayer,
       decoration: BoxDecoration(
           color: Colors.white,
         borderRadius: BorderRadius.circular(10.0)
       ),
       width: MediaQuery.of(context).size.width,
       height: 140,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Image.asset(
             'images/house_test.jpg',
             width: MediaQuery.of(context).size.width * 0.3,
             height: 140,
             fit: BoxFit.cover,
           ),
           const SizedBox(
             width: 10,
           ),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 reusableText(
                     text: '\$${prize.toString()}',
                     fontsize: 20,
                     fontColor: myAppColor,
                     fontWeight: FontWeight.bold
                 ),
                 Container(
                   width: 100,
                   height: 25,
                   decoration:  BoxDecoration(
                     color: myAppColor,
                     borderRadius: const BorderRadius.all(
                       Radius.circular(5),
                     ),
                   ),
                   child: const Center(
                     child: Text(
                       'View',
                       style: TextStyle(color: Colors.white),
                     ),
                   ),
                 ),
                 reusableText(
                   maxLines: 1,
                   text: loc,
                   fontsize: 14,
                   fontWeight: FontWeight.w200,
                   fontColor: Colors.grey,
                 ),
                 Row(
                   children: [
                     const Icon(Icons.bed),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(bedcount.toString()),

                     const Spacer(),

                     const Icon(Icons.bathtub_outlined),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(bedcount.toString()),

                     const Spacer(),

                     const Icon(Icons.area_chart_outlined),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(bedcount.toString()),
                   ],
                 ),
               ],
             ),
           ),
           IconButton(
             onPressed: (){},
             icon: const Icon(
                 Icons.favorite,
                 size: 27.0,
                 color: Colors.red
             ),
             padding: const EdgeInsets.all(8.0),
           )
         ],
       ),
     );
   }
}
