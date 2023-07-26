// ignore_for_file: camel_case_types, must_be_immutable, file_names, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/Search Model.dart';
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
            backgroundColor: ScaffoldColor,
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
                                    controller: searchcontroller),
                              ),
                              Container(
                                color: myAppColor,
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
                                fontColor: Colors.black38,
                                fontWeight: FontWeight.w600,
                                fontsize: 15.0),
                          ),
                        if (cubit.search_model != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
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
                                              BuildCard(
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

  BuildCard(PropertySearchModel item, BuildContext context) {
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
                    fontColor: myAppColor,
                    fontWeight: FontWeight.bold),
                Container(
                  width: 100,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: myAppColor,
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
}
