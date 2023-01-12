abstract class LoginState{}
class LoginInitial extends LoginState{}
class LoginLoading extends LoginState{}
class LoginFailure extends LoginState{
  String errorMessage;
  LoginFailure({required this.errorMessage});
}
class LoginSuccess extends LoginState{}