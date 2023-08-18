// ignore_for_file: camel_case_types, must_be_immutable, file_names, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/Search Model.dart';
import 'package:university_project_property_app/Modules/Property_Details.dart';
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
      child: BlocConsumer<MyBloc, Bloc_States>(
        listener: (context, state) => () {},
        builder: (context, state) {
          searchScreenContext = context;
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColorLight,
            appBar: Search_AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
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
                                    prefixIcon: const Icon(Icons.search,
                                        color: Colors.grey, size: 20),
                                    controller: searchcontroller,
                                ),
                              ),
                              Container(
                                color: myAppColorLight,
                                height: 62.0,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    cubit.Search(
                                        {'name': searchcontroller.text});
                                  },
                                  icon: const Icon(Icons.search,
                                      color: Colors.white, size: 20.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (cubit.search_model == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: reusableText(
                                text:
                                    'You Can Search With : \n1 - Type : house - land - market\n2 - Owner Name : "rami hussin"\n3 - Contract : sell - rent',
                                fontColor: secondryTextColorLight,
                                fontWeight: FontWeight.w600,
                                fontsize: 15.0),
                          ),
                        if (cubit.search_model != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ConditionalBuilder(
                              condition: state is! LoadingSearchProperty,
                              builder: (context) => (cubit
                                      .search_model!.propertylist.isNotEmpty)
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              BuildSearchCard(
                                                  cubit.search_model!
                                                      .propertylist[index],
                                                  context),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10.0),
                                      itemCount: cubit
                                          .search_model!.propertylist.length,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 50.0),
                                      child: Image.asset('images/noresult.png',
                                          height: 150, width: 150),
                                    ),
                              fallback: (context) =>
                                  const CircularProgressIndicator(),
                            ),
                          )
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  BuildSearchCard(PropertySearchModel item, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: containerBackgroundColor,
          borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            (item.image.isNotEmpty) ? item.image[0] : 'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
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
                    text: (item.rent_or_sell == 'sell') ? '\$${item.price.toString()}':
                    '\$${item.monthlyRent.toString()}/Month',
                    fontsize: 20,
                    fontColor: primaryTextColorLight,
                    fontWeight: FontWeight.bold,
                ),
                Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    color: myAppColorLight,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                      child: reusableTextButton(
                          context: context,
                          buttontext: 'View',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.white,
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Property_Details(item)));
                          })),
                ),
                reusableText(
                  maxLines: 1,
                  text: item.address.toString(),
                  fontsize: 14,
                  fontWeight: FontWeight.w200,
                  fontColor: secondryTextColorLight,
                ),
                Row(
                  children: [
                    Icon(Icons.bed_outlined,color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                      text: item.numberofRooms.toString(),
                      fontsize: 13,
                      fontColor: primaryTextColorLight
                    ),
                    const Spacer(),
                    Icon(Icons.bathtub_outlined,color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                      text: item.numberofBaths.toString(),
                      fontsize: 13,
                      fontColor: primaryTextColorLight
                    ),
                    const Spacer(),
                    Icon(Icons.area_chart_outlined,color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                      text: item.area.toString(),
                      fontsize: 13,
                      fontColor: primaryTextColorLight
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, size: 27.0, color: Colors.red),
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
    );
  }
}
