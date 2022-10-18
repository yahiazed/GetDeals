import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  final fireStore = FirebaseFirestore.instance;
  List<MessageModel> cachedMessagesList = [];
  List<MessageModel> msgList = [];
  // Stream<dynamic>? s;
  // getUnReadeMessage() async {
  //   await getCachedMessages();
  //   s!.listen((event) {
  //     event.docs.forEach((msg) {
  //       MessageModel msgData = msg.data();
  //       cachedMessagesList.add(msgData);
  //       List messagesToJson = cachedMessagesList
  //           .map<Map<String, dynamic>>((messageModel) => messageModel.toJson())
  //           .toList();
  //       sharedPreferences.setString('CACHEDMsg', json.encode(messagesToJson));
  //     });
  //   });
  //   await getCachedMessages();
  // }

//getCACHEDMESSAGES
  // Future<List<MessageModel>> getCachedMessages() async {
  //   emit(StartGetCachedMessages());
  //   final jsonString = sharedPreferences.getString('CACHEDMsg');
  //   if (jsonString != null) {
  //     List decodedMessags = json.decode(jsonString);
  //     cachedMessagesList = decodedMessags
  //         .map<MessageModel>((e) => MessageModel.fromJson(e))
  //         .toList();
  //   }
  //   emit(EndGetCachedMessages());
  //   return cachedMessagesList;
  // }

  Future send(
      {required String from,
      required String to,
      required String message,
      String? imageUrl,
      String? docId}) async {
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
        .doc(docId)
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
          .doc(docId)
          .set(MessageModel(
              message: message,
              date: DateTime.now().toString(),
              time: DateFormat.jm().format(DateTime.now()).toString(),
              isSeen: false,
              senderId: from,
              imageUrl: imageUrl,
              receiverId: to));
    });

    // updateLastMessageFromTo(
    //   from: from,
    //   to: to,
    //   message: message,
    // );

    // updateLastMessageToFrom(
    //   from: from,
    //   to: to,
    //   message: message,
    // );

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(from)
    //     .collection('userschat')
    //     .doc(to)
    //     .set({
    //   'receiverId': to,
    //   'lastMessage': message,
    //   'time': DateFormat.jm().format(DateTime.now()).toString(),
    //   'date': DateTime.now()
    // });

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(to)
    //     .collection('userschat')
    //     .doc(from)
    //     .set({
    //   'receiverId': to,
    //   'lastMessage': message,
    //   'time': DateFormat.jm().format(DateTime.now()).toString(),
    //   'date': DateTime.now()
    // });
  }

  Future updateLastMessageFromTo({
    required String from,
    required String to,
    required String message,
    required String senderId,
    bool? isSeen,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(from)
        .collection('userschat')
        .doc(to)
        .set({
      'senderId': senderId,
      'lastMessage': message,
      'time': DateFormat.jm().format(DateTime.now()).toString(),
      'date': DateTime.now(),
      'isSeen': isSeen ?? false
    });
  }

  Future updateLastMessageToFrom({
    required String from,
    required String to,
    required String senderId,
    required String message,
    bool? isSeen,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(to)
        .collection('userschat')
        .doc(from)
        .set({
      'senderId': senderId,
      'lastMessage': message,
      'time': DateFormat.jm().format(DateTime.now()).toString(),
      'date': DateTime.now(),
      'isSeen': isSeen ?? false
    });
  }

  Future updateSeen1(
      {required String senderId, required String receiverId}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .where('isSeen', isEqualTo: false)
        .get()
        .then((value) async {
      value.docs.forEach((docId) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(senderId)
            .collection('chats')
            .doc(receiverId)
            .collection('message')
            .doc(docId.id)
            .update({'isSeen': true});
      });
    });
  }

  Future send2({
    required String to,
    required String from,
    required String message,
  }) async {
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

    // updateLastMessageToFrom(from: from, to: to, message: message);
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(to)
    //     .collection('userschat')
    //     .doc(from)
    //     .set({
    //   'receiverId': to,
    //   'lastMessage': message,
    //   'time': DateFormat.jm().format(DateTime.now()).toString(),
    //   'date': DateTime.now()
    // });
  }

  Future updateSeen({
    required String from,
    required String to,
    required String docId,
    // required String message
  }) async {
    await fireStore
        .collection('users')
        .doc(from)
        .collection('chats')
        .doc(to)
        .collection('message')
        .doc(docId)
        .update({'isSeen': true});
    // updateLastMessageFromTo(
    //     from: from, to: to, message: message , isSeen: true);
    // updateLastMessageToFrom(
    //     from: from, to: to, message: message , isSeen: true);
  }

  Future updateToImage({
    required String from,
    required String to,
    required String message,
    required String imageUrl,
    required String docId,
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
        .doc(docId)
        .update(MessageModel(
                message: message,
                imageUrl: imageUrl,
                date: DateTime.now().toString(),
                time: DateFormat.jm().format(DateTime.now()).toString(),
                isSeen: false,
                senderId: from,
                receiverId: to)
            .toJson())
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
          .doc(docId)
          .update(MessageModel(
                  message: message,
                  imageUrl: imageUrl,
                  date: DateTime.now().toString(),
                  time: DateFormat.jm().format(DateTime.now()).toString(),
                  isSeen: false,
                  senderId: from,
                  receiverId: to)
              .toJson());
    });

    // updateLastMessageFromTo(from: from, to: to, message: 'photo');
    // updateLastMessageToFrom(from: from, to: to, message: 'photo');
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(from)
    //     .collection('userschat')
    //     .doc(to)
    //     .update({
    //   'receiverId': to,
    //   'lastMessage': 'Photo',
    //   'time': DateFormat.jm().format(DateTime.now()).toString()
    // });
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(to)
    //     .collection('userschat')
    //     .doc(from)
    //     .update({
    //   'receiverId': to,
    //   'lastMessage': 'Photo',
    //   'time': DateFormat.jm().format(DateTime.now()).toString()
    // });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? imageFile;

  Future getImage({
    required String from,
    required String to,
  }) async {
    ImagePicker _picker = ImagePicker();
    int o = 0;
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);

        uploadImage(from: from, to: to);
      }
    });
  }

  Future uploadImage({
    required String from,
    required String to,
  }) async {
    String fileName = Uuid().v1();
    int status = 1;
    await send(from: from, to: to, message: 'upload', docId: fileName);
    // emit(StartUploadImage());
    var ref = FirebaseStorage.instance
        .ref()
        .child('chatsImages')
        .child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).whenComplete(() {
      // emit(EndUploadImage());
    }).catchError((error) async {
      await deleteMsg(
        docId: fileName,
        to: to,
        from: from,
      );
      await deleteMsg(
        docId: fileName,
        to: from,
        from: to,
      );

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await updateToImage(
          from: from, to: to, message: '', imageUrl: imageUrl, docId: fileName);

      print(imageUrl);
    }
  }

  Future deleteMsg({
    required String docId,
    required String to,
    required String from,
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
        .doc(docId)
        .delete()
        .whenComplete(() async {
      fireStore
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
          .doc(docId)
          .delete();
    });
  }

  Future acceptPermission(
      {required String projectId,
      required String receiverUID,
      required String receiverName,
      required String senderId,
      required String message}) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('Accept')
        .doc(receiverUID)
        .set({'personName': receiverName, 'uid': receiverUID}).whenComplete(() {
      send2(to: receiverUID, from: senderId, message: message);
    });
  }

  Future rejectPermission(
      {required String projectId,
      required String receiverUID,
      required String receiverName,
      required String senderId,
      required String message}) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('Accept')
        .doc(receiverUID)
        .delete()
        .whenComplete(() {
      send2(to: receiverUID, from: senderId, message: message);
    });
  }
}
