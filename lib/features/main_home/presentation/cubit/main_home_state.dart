part of 'main_home_cubit.dart';

abstract class MainHomeState extends Equatable {
  const MainHomeState();

  @override
  List<Object> get props => [];
}

class MainHomeInitial extends MainHomeState {}

class ChangePageIndexState extends MainHomeState {}

class StartChangePageIndexState extends MainHomeState {}

class StartNotifyMessage extends MainHomeState {}

class EndNotifyMessage extends MainHomeState {}
