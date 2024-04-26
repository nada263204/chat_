part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}
class SuccessState extends MessageState {
   List<Message> messages;
   SuccessState({required this.messages});
}
