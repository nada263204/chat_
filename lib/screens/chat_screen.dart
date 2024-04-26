import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constatnts.dart';
import 'package:scholar_chat/model/message_model.dart';
import 'package:scholar_chat/screens/cubits/cubit/message_cubit.dart';
import 'package:scholar_chat/widgets/chatbuble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable, camel_case_types
class chatScreen extends StatelessWidget {
List <Message> messagesList =[];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  final _controller = ScrollController();

  static String id = 'chatScreen';
  TextEditingController controller = TextEditingController();

  chatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/scholar.png',
              height: 50,
            ),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessageCubit, MessageState>(
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatPop(
                              message: messagesList[index],
                            )
                          : ChatPopForAfriend(
                              message: messagesList[index],
                            );
                    });
              }, listener: (BuildContext context, MessageState state) {
                if(state is SuccessState ){
                  messagesList = state.messages;
                }
               },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<MessageCubit>(context).messageSent(message: data, email: id);
                controller.clear();
                _controller.animateTo(
                  0,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                );
              },
              decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
