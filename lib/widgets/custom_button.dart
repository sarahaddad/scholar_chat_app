import 'package:flutter/material.dart';

class Custom_button extends StatelessWidget {
   Custom_button({this.onTap,required this.text}) ;
String text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
        ),
        height: 60,
        width: double.infinity,
        child:Center(
        child: Text(text,
        ),),
      ),
    );
  }
}
