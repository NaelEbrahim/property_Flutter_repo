// ignore_for_file: camel_case_types, non_constant_identifier_names, must_be_immutable, file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/Filter_Model.dart';
import 'package:university_project_property_app/Modules/Property_Details.dart';
import 'package:university_project_property_app/Shared/App_Bars.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class Filter_Result extends StatelessWidget {
  List<PropertyFilterModel> result = [];

  Filter_Result(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc, Bloc_States>(
        listener: (context, state) => () {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ScaffoldColorLight,
            appBar: AppBar(
              backgroundColor: myAppColorLight,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: reusableText(
                  text: 'Filter Result',
                  fontsize: 19,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: state is! LoadingFilterProperty,
                      builder: (context) => (result.isNotEmpty)
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int index) =>
                                      BuildFilterCard(result[index], context),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10.0),
                              itemCount: result.length,
                            )
                          : Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Image.asset('images/noresult.png',
                                    height: 150, width: 150),
                              ),
                          ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BuildCard(PropertyFilterModel item, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
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
                    text: '\$${item.price.toString()}',
                    fontsize: 20,
                    fontColor: myAppColorLight,
                    fontWeight: FontWeight.bold),
                Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    color: myAppColorLight,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child:  Center(
                    child: reusableTextButton(
                        context: context ,
                        buttontext: 'View',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                        function: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Property_Details(item))
                          );
                        }
                    ),
                  ),
                ),
                reusableText(
                  maxLines: 1,
                  text: item.address.toString(),
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
                    Text(item.numberofRooms.toString()),
                    const Spacer(),
                    const Icon(Icons.bathtub_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('2'),
                    const Spacer(),
                    const Icon(Icons.area_chart_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(item.area.toString()),
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

  BuildFilterCard(PropertyFilterModel item, BuildContext context) {
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
                    fontWeight: FontWeight.bold),
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
                    Icon(Icons.bed_outlined,color: primaryTextColorLight,),
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
                    Icon(Icons.area_chart_outlined,color: primaryTextColorLight,),
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
