
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarchat/cubits/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
 RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required String email,required String password}) async {
    emit(RegisterLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'The account already exists for that email.'));
      }
    }
   catch (ex) {
     RegisterFailure(errorMessage: 'some thing went wrong');

    }
  }

}
