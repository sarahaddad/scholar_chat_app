import 'package:scholarchat/constant.dart';

class MessageModel{
  final String message;
  final String id;

  MessageModel(this.message,this.id);
  factory MessageModel.fromJson(jsondata){
    return MessageModel(jsondata[KMessage],jsondata['id']);
  }
}