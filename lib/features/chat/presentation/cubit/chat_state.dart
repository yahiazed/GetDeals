part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class StartSendGetDealMessage extends ChatState {}

class EndSendGetDealMessage extends ChatState {}

class StartUploadImage extends ChatState {}

class EndUploadImage extends ChatState {}

class StartGetCachedMessages extends ChatState {}

class EndGetCachedMessages extends ChatState {}
