// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:university_project_property_app/Models/Profile_Model.dart';
import 'package:university_project_property_app/Modules/Property_Details.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';


class MyPublications_Screen extends StatelessWidget {
  const MyPublications_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldColor,
      appBar: AppBar(
        backgroundColor: myAppColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: reusableText(
            text: 'My Publications',
            fontsize: 19,
            fontColor: Colors.white,
            fontWeight: FontWeight.bold
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: (user_property.isNotEmpty)?
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) => BuildCard(
              user_property[index],
              context),
          itemCount: user_property.length,
        ):Center(child: Image.asset('images/noresult.png',height: 200.0,width: 200.0)),
      ),
    );
  }

  BuildCard(User_Property item, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            (item.image.isNotEmpty) ? item.image[0] : 'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
            width: MediaQuery.of(context).size.width * 0.3,
            height: 140,
            fit: BoxFit.fill,
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
                  fontWeight: FontWeight.w400,
                  fontColor: Colors.black45,
                ),
                Row(
                  children: [
                    const Icon(Icons.bed),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofRooms.toString(), fontsize: 13),
                    const Spacer(),
                    const Icon(Icons.bathtub_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofBaths.toString(), fontsize: 13),
                    const Spacer(),
                    const Icon(Icons.area_chart_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(text: item.area.toString(), fontsize: 13),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
