import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarchat/cubits/login_cubit/login_cubit.dart';
import 'package:scholarchat/screens/chat_page.dart';
import 'package:scholarchat/screens/login_screen.dart';
import 'package:scholarchat/screens/register_screen.dart';

import 'cubits/chat_cubit/chat_cubit.dart';
import 'cubits/register_cubit/register_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit(),),
        BlocProvider(create: (BuildContext context) => RegisterCubit(),),
        BlocProvider(create: (BuildContext context) => ChatCubit(),),

      ],

      child: MaterialApp(
        routes:{
          LoginScreen.id:(context)=>LoginScreen(),
          RegisterPage.id:(context)=>RegisterPage(),
          chatPage.id:(context)=>chatPage(),

        },
       initialRoute:LoginScreen.id,
      ),
    );
  }
}
