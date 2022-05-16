import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholarchat/constant.dart';
import 'package:scholarchat/screens/chat_page.dart';

import '../helper/showSnackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterScreen';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading=false;

  String? password;

  String? email;

  GlobalKey<FormState>formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(

      inAsyncCall:isLoading,
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
                      'Register',
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
                    hint: 'Password',
                    obsecure: true,
                    onChanged: (data) {
                      password = data;
                    }),
                SizedBox(
                  height: 10,
                ),
                Custom_button(
                  text: 'register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading=true;
                      setState(() {

                      });
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, chatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context,'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'The account already exists for that email.');
                        }
                      }catch(e){
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading=false;
                      setState(() {

                      });

                    }
                    else{

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
                      'Already have an accoıunt?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login  ',
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
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }}
