// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class PhoneOTPVerifiedState extends LoginState {}

class StartEditPhoneState extends LoginState {}

class EditPhoneState extends LoginState {}

class CodeSentState extends LoginState {}

class UserStartExistState extends LoginState {}

class UserExistState extends LoginState {
  UserModel userData;
  UserExistState({
    required this.userData,
  });
}

class UserNotExistState extends LoginState {}

class StartGetUserData extends LoginState {}

class LoginErrorOccurredState extends LoginState {
  final String errorMsg;

  const LoginErrorOccurredState({required this.errorMsg});
}

class LoginErrorOccurredState1 extends LoginState {
  final String errorMsg;

  const LoginErrorOccurredState1({required this.errorMsg});
}
