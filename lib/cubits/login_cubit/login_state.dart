part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}
class LoginFailed extends LoginState {
  final LoginModel loginModel;

  LoginFailed({required this.loginModel});

}
class LoginLoading extends LoginState {}
