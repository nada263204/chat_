import 'package:flutter/material.dart';
import 'package:scholar_chat/constatnts.dart';
import 'package:scholar_chat/model/message_model.dart';


class ChatPop extends StatelessWidget {
  final Message message;
   ChatPop({
    required this.message,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 16,bottom: 16),
        margin: EdgeInsets.all(8),
        height: 65,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(message.message,
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}

class ChatPopForAfriend extends StatelessWidget {
  final Message message;
   ChatPopForAfriend({
    required this.message,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 16,bottom: 16),
        margin: EdgeInsets.all(8),
        height: 65,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Color.fromARGB(255, 143, 158, 241),
        ),
        child: Center(
          child: Text(
            message.message,
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}