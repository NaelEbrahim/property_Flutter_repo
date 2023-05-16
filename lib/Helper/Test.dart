import 'package:flutter/material.dart';
import 'package:university_project_property_app/Shared/Components.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: reusableText(text: "hello", fontsize: 20),
    );
  }
}