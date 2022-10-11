import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  final fireStore = FirebaseFirestore.instance;

  Future sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    //  emit(StartSendGetDealMessage());
    await fireStore
        .collection('users')
        .doc(from)
        .collection('chats')
        .doc(to)
        .collection('message')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        )
        .doc()
        .set(MessageModel(
            message: message,
            date: DateTime.now().toString(),
            time: DateFormat.jm().format(DateTime.now()).toString(),
            isSeen: false,
            senderId: from,
            receiverId: to));
  }

  Future send({
    required String from,
    required String to,
    required String message,
  }) async {
    await fireStore
        .collection('users')
        .doc(from)
        .collection('chats')
        .doc(to)
        .collection('message')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        )
        .doc()
        .set(MessageModel(
            message: message,
            date: DateTime.now().toString(),
            time: DateFormat.jm().format(DateTime.now()).toString(),
            isSeen: false,
            senderId: from,
            receiverId: to))
        .whenComplete(() async {
      await fireStore
          .collection('users')
          .doc(to)
          .collection('chats')
          .doc(from)
          .collection('message')
          .withConverter<MessageModel>(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (message, options) => message.toJson(),
          )
          .doc()
          .set(MessageModel(
              message: message,
              date: DateTime.now().toString(),
              time: DateFormat.jm().format(DateTime.now()).toString(),
              isSeen: false,
              senderId: from,
              receiverId: to));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(from)
        .collection('userschat')
        .doc(to)
        .set({
      'receiverId': to,
      'lastMessage': message,
      'time': DateFormat.jm().format(DateTime.now()).toString()
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(to)
        .collection('userschat')
        .doc(from)
        .set({
      'receiverId': to,
      'lastMessage': message,
      'time': DateFormat.jm().format(DateTime.now()).toString()
    });
  }
}
