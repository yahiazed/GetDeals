import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/core/utiles/snackbar.dart';

import 'package:intl/intl.dart';

import '../../../add_project/domain/post_model.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../domain/messageModel.dart';

part 'explore_projects_state.dart';

class ExploreProjectsCubit extends Cubit<ExploreProjectsState> {
  ExploreProjectsCubit() : super(ExploreProjectsInitial());
  static ExploreProjectsCubit get(context) => BlocProvider.of(context);
  List<ProjectModel> projectList = [];
  bool first = true;

  final fireStore = FirebaseFirestore.instance;

  final projectRef = FirebaseFirestore.instance
      .collection('projects')
      .withConverter<ProjectModel>(
        fromFirestore: (snapshot, _) => ProjectModel.fromJson(snapshot.data()!),
        toFirestore: (project, _) => project.toJson(),
      );
  late CollectionReference<ProjectModel> query;
  getQuery() {
    query = FirebaseFirestore.instance
        .collection('projects')
        .withConverter<ProjectModel>(
          fromFirestore: (snapshot, _) =>
              ProjectModel.fromJson(snapshot.data()!),
          toFirestore: (project, _) => project.toJson(),
        );
  }

  Future sendGetDeal(
      {required UserModel sender, required ProjectModel project}) async {
    emit(StartSendGetDealMessage());
    await fireStore
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(project.userUid)
        .collection('message')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        )
        .doc()
        .set(MessageModel(
            message:
                '${sender.name}Need To Get More Information About${project.projectName}',
            date: DateTime.now().toString(),
            time: DateFormat.jm().format(DateTime.now()).toString(),
            isSeen: false,
            senderId: sender.uid,
            receiverId: project.userUid))
        .whenComplete(() async {
      await sendNotifyToAssem(project: project, sender: sender)
          .whenComplete(() {
        emit(EndSendingGetDealMessage());
      });
    });
  }

  Future sendGetDeal1(
      {required UserModel sender, required ProjectModel project}) async {
    await sendMessage(
            from: sender.uid,
            to: project.userUid,
            message: 'I Ask For${project.projectName}')
        .whenComplete(() async {
      await sendMessage2(
              from: project.userUid,
              to: sender.uid,
              message:
                  '${sender.name}Hello, I need More Information About${project.projectName}')
          .whenComplete(() {
        emit(EndSendingGetDealMessage1());
        FirebaseFirestore.instance
            .collection('users')
            .doc(sender.uid)
            .collection('userschat')
            .doc(project.userUid)
            .set({
          'receiverId': project.userUid,
          'lastMessage':
              '${sender.name}Hello, I need More Information About${project.projectName}',
          'time': DateFormat.jm().format(DateTime.now()).toString()
        }).whenComplete(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(project.userUid)
              .collection('userschat')
              .doc(sender.uid)
              .set({
            'receiverId': project.userUid,
            'lastMessage':
                '${sender.name}Hello, I need More Information About${project.projectName}',
            'time': DateFormat.jm().format(DateTime.now()).toString()
          });
        }).whenComplete(() async {
          await sendNotifyToAssem(project: project, sender: sender);
        });
      });
    });
  }

  Future sendNotifyToAssem(
      {required UserModel sender, required ProjectModel project}) async {
    await FirebaseFirestore.instance.collection('notifyProjects').doc().set({
      'senderId': sender.uid,
      'senderName': sender.name,
      'receiverId': project.userUid,
      'projectName': project.projectName,
      'date': DateTime.now(),
      'formatDate': DateFormat.yMMMd().format(DateTime.now()),
    }).whenComplete(() {
      emit(EndSendingGetDealMessage());
    });
  }

  Future sendNotification({
    required UserModel senderUser,
    required String receiverId,
    required ProjectModel projectModel,
    required String projectId,
    required String notifyMsg,
    required BuildContext context,
  }) async {
    emit(StartSendNotifications());
    await fireStore.collection('notifications').doc().set({
      'projectName': projectModel.projectName,
      'projectId': projectId,
      'imgUrl': senderUser.photo,
      'senderName': senderUser.name,
      'senderId': senderUser.uid,
      'receiverId': receiverId,
      'NotifyMsg': senderUser.name + notifyMsg + projectModel.projectName,
      'date': DateTime.now().toString(),
      'time': DateFormat.jm().format(
        DateTime.now(),
      )
    }).whenComplete(() async {
      CustomSnackBar().showSuccessSnackBar(
          message: 'Send To Owner To Get Permission'.tr(context),
          context: context);
      emit(EndSendNotifications());
    });
  }

  Future sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    emit(StartSendGetDealMessage());
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

  Future sendMessage2({
    required String from,
    required String to,
    required String message,
  }) async {
    emit(StartSendGetDealMessage());
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
            senderId: to,
            receiverId: from));
  }
}
