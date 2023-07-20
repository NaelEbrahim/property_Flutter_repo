import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

Widget reusableText(
        {required String text,
        required double fontsize,
        int maxLines = 5,
        FontWeight fontWeight = FontWeight.normal,
        Color fontColor = Colors.black,
        bool linethrough = false,
        TextAlign align = TextAlign.start
        }) =>
    Text(
      text,
      maxLines: maxLines,
      textAlign: align ,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          fontSize: fontsize,
          color: fontColor,
          decoration:
              (linethrough) ? TextDecoration.lineThrough : TextDecoration.none),
    );

Widget reusableTextField(
        {required String hintText,
        required Icon prefixIcon,
        TextStyle? hintstyle,
        IconData? suffixIcon,
        void Function()? suffixfunction,
        required TextEditingController controller,
        bool obscureText = false,
        double raduis = 0.0,
        Color fontColor = myAppColor,
        int maxlines = 1 ,
        Color focuseColor = myAppColor,
        TextInputType textInputType = TextInputType.text}) =>
    TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLines: maxlines,
      style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: BorderSide(color: focuseColor ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: (suffixIcon != null ) ? IconButton(
          onPressed: suffixfunction,
          icon: Icon(suffixIcon),
        ) : null ,
        hintText: hintText,
        hintStyle:hintstyle ?? GoogleFonts.raleway(color: Colors.black),
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'must\'t be empty';
        }
        return null;
      },
    );

Widget reusableTextButton(
        {required BuildContext context,
        required String buttontext,
        required Function() function,
        Color textColor = Colors.black,
        double fontSize = 20.0,
        FontWeight fontWeight = FontWeight.normal}) =>
    TextButton(
        onPressed: function,
        child: reusableText(
            text: buttontext,
            fontsize: fontSize,
            fontColor: textColor,
            fontWeight: fontWeight));
