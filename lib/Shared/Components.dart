import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableText(
        {required String text,
        required double fontsize,
        int maxLines = 5,
        FontWeight fontWeight = FontWeight.normal,
        Color fontColor = Colors.black,
        bool linethrough = false}) =>
    Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
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
        TextInputType textInputType = TextInputType.text}) =>
    TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.indigo),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          onPressed: suffixfunction,
          icon: Icon(suffixIcon),
        ),
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
