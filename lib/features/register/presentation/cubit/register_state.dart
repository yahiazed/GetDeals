// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class PhoneNumberSubmitedState extends RegisterState {}

class PhoneOTPVerifiedState extends RegisterState {}

class AddingNewUserLoadingState extends RegisterState {}

class AddingNewUserSuccessState extends RegisterState {}

class UserStartExistState extends RegisterState {}

class UserExistState extends RegisterState {}

class CodeSentState extends RegisterState {}

class AddingNewUserErrorState extends RegisterState {
  final String errorMsg;

  AddingNewUserErrorState({required this.errorMsg});
}

class RegisterErrorOccurredState extends RegisterState {
  final String errorMsg;
  const RegisterErrorOccurredState({
    required this.errorMsg,
  });
}

class RegisterErrorOccurredState1 extends RegisterState {
  final String errorMsg;
  const RegisterErrorOccurredState1({
    required this.errorMsg,
  });
}
