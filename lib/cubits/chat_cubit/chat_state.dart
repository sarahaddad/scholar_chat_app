
import 'package:scholarchat/models/message_model.dart';

abstract class ChatState{}
class ChatInitial extends ChatState{}
class ChatSuccess extends ChatState{
  List<MessageModel>messages;
  ChatSuccess({required this.messages});

}