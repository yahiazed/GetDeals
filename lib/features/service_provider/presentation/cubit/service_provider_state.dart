part of 'service_provider_cubit.dart';

abstract class ServiceProviderState extends Equatable {
  const ServiceProviderState();

  @override
  List<Object> get props => [];
}

class ServiceProviderInitial extends ServiceProviderState {}

class StartSendGetDealMessage extends ServiceProviderState {}

class EndSendingGetDealMessage extends ServiceProviderState {}

class EndSendingGetDealMessage1 extends ServiceProviderState {}

class EndRateFreelancer extends ServiceProviderState {}

class StartRateFreelancer extends ServiceProviderState {}

class StartSetQuery extends ServiceProviderState {}

class EndSetQuery extends ServiceProviderState {}
