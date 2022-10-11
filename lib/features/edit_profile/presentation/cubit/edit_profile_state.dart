part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class StatrtSelectImage extends EditProfileState {}

class StartSetDataState extends EditProfileState {}

class EndSetDataState extends EditProfileState {}

class EndSelectImage extends EditProfileState {}

class StartUploadImageState extends EditProfileState {}

class EndUploadImageState extends EditProfileState {}

class StartUpdateProfileDataState extends EditProfileState {}

class EndUpdateProfileDataState extends EditProfileState {}

class ErrorUpdateProfileState extends EditProfileState {}

class SuccessUpdateState extends EditProfileState {}
