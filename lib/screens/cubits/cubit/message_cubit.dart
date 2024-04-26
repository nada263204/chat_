import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/constatnts.dart';
import 'package:scholar_chat/model/message_model.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

   CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);
   List <Message> messagesList =[];
  void messageSent({required String message,required String email})
  {
    messages.add({
            kMessage : message,
            kCreatedAt:DateTime.now(),
            'id': email
          });
  }
  void getMessages()
  {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event)
     {
      messagesList.clear();
      for(var doc in event.docs)
      {
        messagesList.add(Message.fromJson(doc));
      }
      emit(SuccessState(messages: messagesList));
     });
  }
}
