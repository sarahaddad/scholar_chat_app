import 'package:flutter/material.dart';

class customFormTextField extends StatelessWidget {
   customFormTextField({this.onChanged,this.hint,this.obsecure=false});
    String? hint;
    Function(String)? onChanged;
    bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure!,
      validator: (data){
        if(data!.isEmpty)
          return'this field is reqeuired';
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),

        ),),);
  }
}
