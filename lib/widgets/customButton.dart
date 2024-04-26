// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customButton extends StatelessWidget {
   VoidCallback onClicked;
   final String text;
  customButton({
    Key? key, required this.onClicked,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text,)),
      ),
    );
  }

}
