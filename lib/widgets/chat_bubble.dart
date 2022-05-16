
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message_model.dart';

class chatBubble extends StatelessWidget {
  const chatBubble({required this.message,
    Key? key,
  }) : super(key: key);
final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding: EdgeInsets.only(
          left: 16,
          right: 20,
            top: 25,
          bottom: 25,
        ),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: KPrimaryColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class chatBubbleWithFreiend extends StatelessWidget {
  const chatBubbleWithFreiend({required this.message,
    Key? key,
  }) : super(key: key);
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        padding: EdgeInsets.only(
          left: 16,
          right: 20,
          top: 25,
          bottom: 25,
        ),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.indigoAccent,
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}