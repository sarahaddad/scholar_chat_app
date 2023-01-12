import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholarchat/constant.dart';
import 'package:scholarchat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholarchat/cubits/login_cubit/login_cubit.dart';
import 'package:scholarchat/cubits/login_cubit/login_state.dart';
import 'package:scholarchat/screens/chat_page.dart';
import 'package:scholarchat/screens/register_screen.dart';
import 'package:scholarchat/screens/test.dart';
import 'package:scholarchat/widgets/custom_button.dart';
import 'package:scholarchat/widgets/custom_text_field.dart';

import '../helper/showSnackBar.dart';

class LoginScreen extends StatelessWidget{

  static String id = 'login page';

  bool isLoading = false;
  String? password;
  String? email;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>(
      listener: (context, state) {
     //Listener  not doing any rebuild just some code
        if(state is LoginLoading){
          isLoading=true;
        }
        else if(state is LoginSuccess){
          //The previous list messages have to be show before we send any message so we take  with the email it when we navigate
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, chatPage.id,arguments: email);
          isLoading=false;

      }
        else if(state is LoginFailure){
          isLoading=false;
         showSnackBar(context, state.errorMessage);

        }},
      child:  ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: KPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Text(
                        'LOGIN',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  customFormTextField(

                    hint: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customFormTextField(
                    obsecure: true,
                    hint: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Custom_button(
                    text: 'LOGIN',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).signinUser(email: email!, password: password!);
                      } else {

                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an accoıunt?  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          'Register  ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      )

    );
  }

  Future<void> signinUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
