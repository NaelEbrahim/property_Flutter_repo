// ignore_for_file: camel_case_types, file_names
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

   var CurrentBottomNavIndex = 0 ;

  List img = [
    'images/house_test.jpg',
    'images/house_test.jpg',
    'images/house_test.jpg',
  ];

  @override
  Widget build(BuildContext context){
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc , Bloc_States>(
        listener: (context, state) => (){},
        builder: (context, state){
          var cubit = MyBloc.get(context);
          return Scaffold(
              backgroundColor: ScaffoldColor,
              appBar: AppBar(
                backgroundColor: Colors.grey[200],
                bottomOpacity: 0.0,
                elevation: 0.0,
                // title:
                centerTitle: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    reusableText(
                      text: 'Current Location',
                      fontsize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                        ),
                        reusableText(text: 'Syria - Damascus', fontsize: 16),
                      ],
                    ),
                  ],
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
                leading: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: reusableTextField(
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
                    ),
                    CarouselSlider.builder(
                      itemCount: img.length,
                      itemBuilder: (context, index, l) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: 300,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.asset(
                                'images/house_test.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return card(204500, 'Syria - Damascus - Al Amin', 4,3,150,context);
                      },
                      itemCount: 5,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.black
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
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(icon: Icon(Icons.house),label: 'Home'),
                        BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: 'Filter'),
                        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
                        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
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
   card(int prize, String loc, int bedcount,int bathcount,int area,BuildContext context) {
     return SizedBox(
       width: MediaQuery.of(context).size.width * 0.93,
       height: 140,
       child: Row(
         children: [
           ClipRRect(
             borderRadius: const BorderRadius.all(Radius.circular(10)),
             child: Image.asset(
               'images/house_test.jpg',
               width: MediaQuery.of(context).size.width * 0.3,
               height: 130,
               fit: BoxFit.fill,
             ),
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
                     fontColor: Colors.blue,
                     fontWeight: FontWeight.bold
                 ),
                 Container(
                   width: 100,
                   height: 25,
                   decoration: const BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.all(
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

                     const SizedBox(width:40.0),

                     const Icon(Icons.bathtub_outlined),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(bedcount.toString()),

                     const SizedBox(width:40.0),

                     const Icon(Icons.area_chart_outlined),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(bedcount.toString()),

                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     );
   }
}
