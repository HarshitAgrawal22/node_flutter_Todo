import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  bool isPassword;
  TextEditingController givenController;
  FocusNode? focusNode;
  String textToShow;
  Color fieldColor;
  Color? enabledBorderColor;
  Color? focusBorderColor;

  MyTextfield(
      {super.key,
      this.focusBorderColor,
      this.enabledBorderColor,
      required this.fieldColor,
      required this.textToShow,
      required this.isPassword,
      required this.givenController,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 35,
          vertical: MediaQuery.of(context).size.height / 50),
      child: TextField(
        style: TextStyle(),
        obscureText: isPassword ?? false,
        controller: givenController,
        // for text controlling
        focusNode: focusNode,
        decoration: InputDecoration(
          // prefixIcon:
          fillColor: fieldColor,

          hintText: textToShow,
          enabledBorder: OutlineInputBorder(
            // this is the border when the field isnt selected by the user
            borderSide:
                BorderSide(color: enabledBorderColor ?? Colors.indigo.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            //this is the field when the field is selected by the user
            borderSide: BorderSide(
              color: focusBorderColor ?? Colors.blue.shade700,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
