// ignore_for_file: camel_case_types, file_names
import 'package:flutter/material.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class Favourite_Screen extends StatelessWidget {
  const Favourite_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => card(25300,"Damascus",3,2,120,context),
                  separatorBuilder: (context, index) => const SizedBox(height: 20.0),
                  itemCount: 10
              ),
            ],
          ),
        ),
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
