part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class StartGetData extends HomeState {}

class EndGetData extends HomeState {}

class StartSendingOrderToOwner extends HomeState {}

class EndSendingOrderToOwner extends HomeState {}
