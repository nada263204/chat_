// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String hintText;
  Function(String)? onChanged;
   CustomTextFormField({
    Key? key,
     this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'this field is required';
        }
        return null;
      },
      onChanged: onChanged ,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          )
        )
      ),
    );
  }
}
