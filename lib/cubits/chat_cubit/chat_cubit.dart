import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarchat/cubits/chat_cubit/chat_state.dart';
import 'package:scholarchat/models/message_model.dart';

import '../../constant.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
  FirebaseFirestore.instance.collection(KMessageCollection);

  void sendMessage({required String email,required String message}){
    messages.add({
      'message': message,
      KCreatedAt: DateTime.now(),
      'id':email,
      //here we can do a failure state ,when the message did not go to the firebase so we can show it in the fire base as a not going msg !(try catch)
    });
  }
  void getMessage(){
    //The previous list messages have to be show before we send any message so we take it  with the email  when we navigate from login to chatPage

    messages.orderBy(KCreatedAt,descending: true).snapshots().listen((event) {
      //here the message sending success because here we receive it and show it in the UI
      List<MessageModel>messageList=[];
      for(var doc in event.docs){
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
}

}