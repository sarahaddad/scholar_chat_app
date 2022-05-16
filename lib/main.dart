import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholarchat/screens/chat_page.dart';
import 'package:scholarchat/screens/login_screen.dart';
import 'package:scholarchat/screens/register_screen.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const scholarChat());
}

class scholarChat extends StatelessWidget {
  const scholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        LoginScreen.id:(context)=>LoginScreen(),
        RegisterPage.id:(context)=>RegisterPage(),
        chatPage.id:(context)=>chatPage(),

      },
     initialRoute:LoginScreen.id,
    );
  }
}
