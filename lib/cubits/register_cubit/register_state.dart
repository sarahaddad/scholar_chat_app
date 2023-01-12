abstract class RegisterState{}
class RegisterInitial extends RegisterState{}
class RegisterLoading extends RegisterState{}
class RegisterFailure extends RegisterState{
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}
class RegisterSuccess extends RegisterState{}