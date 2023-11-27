part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UpdateUserProfileLoading extends UserState {}
class UpdateUserProfileSuccess extends UserState {}
class UpdateUserProfileFailed extends UserState {
  final String errorMessage;

  UpdateUserProfileFailed({required this.errorMessage});
}
class GetUserDataSuccessfully extends UserState{}
class RegisterUserLoading extends UserState {}
class RegisterUserFailed extends UserState {
  final String errorMessage;

  RegisterUserFailed({required this.errorMessage});
}
class RegisterUserSuccess extends UserState{

  final String message;

  RegisterUserSuccess({required this.message});
}

