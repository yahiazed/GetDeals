part of 'add_project_cubit.dart';

abstract class AddProjectState extends Equatable {
  const AddProjectState();

  @override
  List<Object> get props => [];
}

class AddProjectInitial extends AddProjectState {}

class StatrtSelectImage extends AddProjectState {}

class EndSelectImage extends AddProjectState {}

class StartSelectFiles extends AddProjectState {}

class EndSelectFiles extends AddProjectState {}

class StartUploadImageState extends AddProjectState {}

class SuccessAddNewProjectState extends AddProjectState {}

class StartDropDownChanged extends AddProjectState {}

class EndDropDownChanged extends AddProjectState {}

class ErrorAddNewProjectState extends AddProjectState {
  final String errMsg;

  const ErrorAddNewProjectState({required this.errMsg});
}

class StartAddingNewProjectState extends AddProjectState {}

class SuccessUploadImageState extends AddProjectState {}

class ErrorUploadImageState extends AddProjectState {}
