import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../add_project/domain/post_model.dart';
import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';

part 'service_provider_state.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit() : super(ServiceProviderInitial());
  static ServiceProviderCubit get(context) => BlocProvider.of(context);
  List<String> experienceskindList = ['Companies', "Freelancer"];
  List<String> experiencesRateList = ['0', '1', "2", '3', '4', '5'];
  final List<String> specialistList = [
    "Law",
    "Finance",
    "management consulting",
    "Graphic Design",
    "Programing",
    "Account management",
  ];

  String experienceskind = 'Companies';
  String experiencesRate = '0';
  String specialist = "Law";

  Query<UserModel>? query;
  setQuery() {
    emit(StartSetQuery());
    query = FirebaseFirestore.instance
        .collection('users')
        .where('userKind', isEqualTo: 1)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJsonServiceProvider(snapshot.data()!),
          toFirestore: (user, _) => user.toJsonServiceProvider(),
        );

    emit(EndSetQuery());
  }

  setQueryKind() {
    emit(StartSetQuery());
    query = FirebaseFirestore.instance
        .collection('users')
        .where('userKind', isEqualTo: 1)
        .where('serviceProviderKind', isEqualTo: experienceskind)
        .where('specialist', isEqualTo: specialist)
        .where('rate', isEqualTo: experiencesRate)
        // .orderBy('projectDate', descending: true)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJsonServiceProvider(snapshot.data()!),
          toFirestore: (user, _) => user.toJsonServiceProvider(),
        );
    emit(EndSetQuery());
  }

  setQuerySpecialist() {
    emit(StartSetQuery());
    query = FirebaseFirestore.instance
        .collection('users')
        .where('userKind', isEqualTo: 1)
        .where('serviceProviderKind', isEqualTo: experienceskind)
        .where('specialist', isEqualTo: specialist)

        // .orderBy('projectDate', descending: true)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJsonServiceProvider(snapshot.data()!),
          toFirestore: (user, _) => user.toJsonServiceProvider(),
        );
    print('nknk' + experienceskind);
    print(specialist);
    emit(EndSetQuery());
  }

  setQueryRate() {
    emit(StartSetQuery());
    query = FirebaseFirestore.instance
        .collection('users')
        .where('userKind', isEqualTo: 1)
        .where('serviceProviderKind', isEqualTo: experienceskind)
        .where('specialist', isEqualTo: specialist)
        .where('rate', isLessThanOrEqualTo: experiencesRate)
        .orderBy('rate')
        // .orderBy('projectDate', descending: true)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJsonServiceProvider(snapshot.data()!),
          toFirestore: (user, _) => user.toJsonServiceProvider(),
        );
    print(experienceskind);
    print(specialist);
    print(experiencesRate);
    emit(EndSetQuery());
  }

  Future sendGetDeal1(
      {required UserModel sender, required UserModel provider}) async {
    await sendMessage(
            from: sender.uid,
            to: provider.uid,
            message: 'I Ask For${provider.specialist}')
        .whenComplete(() async {
      await sendMessage2(
              from: provider.uid,
              to: sender.uid,
              message:
                  '${sender.name}Hello, I need More Information About${provider.specialist}')
          .whenComplete(() {
        emit(EndSendingGetDealMessage1());
        FirebaseFirestore.instance
            .collection('users')
            .doc(sender.uid)
            .collection('userschat')
            .doc(provider.uid)
            .set({
          'receiverId': provider.uid,
          'lastMessage':
              '${sender.name}Hello, I need More Information About${provider.specialist}',
          'time': DateFormat.jm().format(DateTime.now()).toString()
        }).whenComplete(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(provider.uid)
              .collection('userschat')
              .doc(sender.uid)
              .set({
            'receiverId': provider.uid,
            'lastMessage':
                '${sender.name}Hello, I need More Information About${provider.specialist}',
            'time': DateFormat.jm().format(DateTime.now()).toString()
          });
        }).whenComplete(() async {
          await sendNotifyToAssem(
            project: provider,
            sender: sender,
          );
        });
      });
    });
  }

  Future sendNotifyToAssem(
      {required UserModel sender, required UserModel project}) async {
    await FirebaseFirestore.instance.collection('notifyProjects').doc().set({
      'senderId': sender.uid,
      'senderName': sender.name,
      'receiverId': project.uid,
      'receiverName': project.name,
      'date': DateTime.now(),
      'formatDate': DateFormat.yMMMd().format(DateTime.now()),
      'sp': project.specialist
    }).whenComplete(() {
      emit(EndSendingGetDealMessage());
    });
  }

  Future sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    emit(StartSendGetDealMessage());
    await FirebaseFirestore.instance
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

  Future sendMessage2({
    required String from,
    required String to,
    required String message,
  }) async {
    emit(StartSendGetDealMessage());
    await FirebaseFirestore.instance
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
            senderId: to,
            receiverId: from));
  }

  Future commentServiceProvider({
    required UserModel accessUser,
    required UserModel serviceProvider,
    required String comment,
    required double rate,
  }) async {
    emit(StartRateFreelancer());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(serviceProvider.uid)
        .collection('comments')
        .doc(accessUser.uid)
        .set({
      'comment': comment,
      'rate': rate,
      'time': DateFormat.yMMMd().format(DateTime.now()).toString()
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(serviceProvider.uid)
          .update({'rate': rate}).whenComplete(() {
        emit(EndRateFreelancer());
      });
    });
  }
}
