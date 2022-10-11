part of 'explore_projects_cubit.dart';

abstract class ExploreProjectsState extends Equatable {
  const ExploreProjectsState();

  @override
  List<Object> get props => [];
}

class ExploreProjectsInitial extends ExploreProjectsState {}

class StartGetTopProjectState extends ExploreProjectsState {}

class EndGetTopProjectState extends ExploreProjectsState {}

class StartGetNewProjectToListState extends ExploreProjectsState {}

class EndSendingGetDealMessage1 extends ExploreProjectsState {}

class EndGetNewProjectToListState extends ExploreProjectsState {}

class StartSendGetDealMessage extends ExploreProjectsState {}

class EndSendingGetDealMessage extends ExploreProjectsState {}

class StartSendNotifications extends ExploreProjectsState {}

class EndSendNotifications extends ExploreProjectsState {}
