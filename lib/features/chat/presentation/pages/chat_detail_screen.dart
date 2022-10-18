import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/features/chat/presentation/pages/show_image.dart';

import '../../../../config/fIcons.dart';
import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/chat_cubit.dart';

class ChatDetailScreen extends StatelessWidget {
  UserModel sender;
  UserModel? receiverUser;
  String? receiverUID;
  String? projectId;
  int i = 0;
  ChatDetailScreen(
      {super.key, required this.sender, this.receiverUID, this.receiverUser});
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var msgController = TextEditingController();
    String lastMessage = '';
    String senderId = '';
    bool isSeen = false;
    final streamMessages = FirebaseFirestore.instance
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(receiverUID)
        .collection('message')
        // .where('isSeen', isEqualTo: false)
        .orderBy('date', descending: true)
        // .where('isSeen', isEqualTo: false)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
    //ChatCubit.get(context).s = streamMessages;
    print(i++);
    return WillPopScope(
      onWillPop: () async {
        await ChatCubit.get(context)
            .updateLastMessageFromTo(
                from: sender.uid,
                to: receiverUser?.uid ?? receiverUID!,
                message: lastMessage,
                senderId: senderId,
                isSeen: isSeen)
            .whenComplete(() async {
          // await ChatCubit.get(context).updateLastMessageToFrom(
          //     from: sender.uid,
          //     to: receiverUser?.uid ?? receiverUID!,
          //     senderId: senderId,
          //     message: lastMessage,
          //     isSeen: isSeen);
        });

        return true;
      },
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);

          return Scaffold(
              backgroundColor: Colord.mainColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colord.mainColor,

                title: SharedTitle(
                  txt: receiverUser?.name ?? "chats".tr(context),
                ),
                leadingWidth: 66.0,
                actions: const [SharedAction()],
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    receiverUser?.photo ??
                        'https://img.freepik.com/free-photo/red-black-brush-stroke-banner-background-perfect-canva_1361-3597.jpg?w=826&t=st=1665253794~exp=1665254394~hmac=a2260fa4e07ac0e4c74a498d57dbcd3364059c7642dbc8d11dcc48ef8743838e',
                  ),
                ),
                // shape: RoundedShape.roundedAppBar(),
                toolbarHeight: 100,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  color: Colord.whit,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/bg.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(52),
                    topRight: Radius.circular(52),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: streamMessages,
                        //  FirebaseFirestore.instance
                        //     .collection('users')
                        //     .doc(sender.uid)
                        //     .collection('chats')
                        //     .doc(receiverUID)
                        //     .collection('message')
                        //     .where('isSeen', isEqualTo: false)
                        //     .orderBy('date', descending: true)
                        //     // .where('isSeen', isEqualTo: false)
                        //     .withConverter<MessageModel>(
                        //       fromFirestore: (snapshot, options) =>
                        //           MessageModel.fromJson(snapshot.data()!),
                        //       toFirestore: (value, options) => value.toJson(),
                        //     )
                        //     .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: scrollController,
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  bool isMe = snapshot.data!.docs[index]
                                          .data()
                                          .senderId ==
                                      sender.uid;
                                  lastMessage =
                                      snapshot.data!.docs.first.data().message;
                                  if (!snapshot.data!.docs[index]
                                      .data()
                                      .isSeen) {
                                    cubit.updateSeen1(
                                      receiverId:
                                          receiverUser?.uid ?? receiverUID!,
                                      senderId: sender.uid,
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: isMe
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          margin: const EdgeInsets.all(8),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                              color: isMe
                                                  ? Colord.mainColor
                                                  : Colord.main2,
                                              borderRadius: isMe
                                                  ? const BorderRadiusDirectional
                                                      .only(
                                                      topStart:
                                                          Radius.circular(1),
                                                      topEnd:
                                                          Radius.circular(8),
                                                      bottomStart:
                                                          Radius.circular(30),
                                                      bottomEnd:
                                                          Radius.circular(8),
                                                    )
                                                  : const BorderRadiusDirectional
                                                      .only(
                                                      topStart:
                                                          Radius.circular(8),
                                                      topEnd:
                                                          Radius.circular(1),
                                                      bottomStart:
                                                          Radius.circular(8),
                                                      bottomEnd:
                                                          Radius.circular(30),
                                                    )),
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .75),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (snapshot.data!.docs[index]
                                                      .data()
                                                      .imageUrl !=
                                                  null)
                                                buildImageInChat(
                                                    context: context,
                                                    snapshot: snapshot,
                                                    index: index,
                                                    isMe: isMe),
                                              if (snapshot.data!.docs[index]
                                                  .data()
                                                  .message
                                                  .isNotEmpty)
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      .data()
                                                      .message,
                                                  style: isMe
                                                      ? txt414White()
                                                      : hint414blackOpacityText(),
                                                ),
                                              if (snapshot.data!.docs[index]
                                                      .data()
                                                      .type ==
                                                  'permission')
                                                Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          cubit.acceptPermission(
                                                              senderId:
                                                                  sender.uid,
                                                              message:
                                                                  '${sender.name}${"Accept To Get Project Files".tr(context)}',
                                                              projectId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()
                                                                  .projectId!,
                                                              receiverUID:
                                                                  receiverUser!
                                                                      .uid,
                                                              receiverName:
                                                                  receiverUser!
                                                                      .name);
                                                          // FirebaseFirestore
                                                          //     .instance
                                                          //     .collection(
                                                          //         'projects')
                                                          //     .doc(snapshot.data!
                                                          //         .docs[index]
                                                          //         .data()
                                                          //         .projectId)
                                                          //     .collection(
                                                          //         'Accept')
                                                          //     .doc(receiverUser
                                                          //         ?.uid)
                                                          //     .set({
                                                          //   'personName':
                                                          //       receiverUser
                                                          //           ?.name,
                                                          //   'uid':
                                                          //       receiverUser?.uid
                                                          // });
                                                        },
                                                        child: Text(
                                                          'Accept'.tr(context),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          cubit.rejectPermission(
                                                              senderId:
                                                                  sender.uid,
                                                              message:
                                                                  '${sender.name}${"Reject To Get Project Files".tr(context)}',
                                                              projectId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()
                                                                  .projectId!,
                                                              receiverUID:
                                                                  receiverUser!
                                                                      .uid,
                                                              receiverName:
                                                                  receiverUser!
                                                                      .name);
                                                        },
                                                        child: Text(
                                                          'Refuse'.tr(context),
                                                        )),
                                                  ],
                                                ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    .data()
                                                    .time,
                                                style: txt210White(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }

                          return Center(
                              child: Text(
                            'No Chat Yet!!',
                            style: title1(),
                          ));
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: buildTextInput(
                        context: context,
                        controller: msgController,
                        sendingImage: () async {
                          await cubit.getImage(
                            from: sender.uid,
                            to: receiverUID!,
                          );
                        },
                        sending: () async {
                          await cubit.send(
                              from: sender.uid,
                              to: receiverUID!,
                              message: msgController.text);
                          scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          cubit.updateLastMessageToFrom(
                              from: sender.uid,
                              to: receiverUser?.uid ?? receiverUID!,
                              senderId: senderId,
                              message: lastMessage,
                              isSeen: isSeen);
                          // cubit
                          //     .updateLastMessageFromTo(
                          //         from: sender.uid,
                          //         to: receiverUser?.uid ?? receiverUID!,
                          //         message: msgController.text,
                          //         senderId: senderId,
                          //         isSeen: false)
                          //     .whenComplete(() async {
                          //   await cubit.updateLastMessageToFrom(
                          //       from: sender.uid,
                          //       to: receiverUser?.uid ?? receiverUID!,
                          //       senderId: senderId,
                          //       message: msgController.text,
                          //       isSeen: false);
                          // });
                        },
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget buildImageInChat(
      {required BuildContext context,
      required AsyncSnapshot<QuerySnapshot<MessageModel>> snapshot,
      required int index,
      required bool isMe}) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            ShowSendImage(
              img: snapshot.data!.docs[index].data().imageUrl!,
            ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        padding: EdgeInsets.only(bottom: 5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: isMe
            ? Image.network(
                snapshot.data!.docs[index].data().imageUrl!,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: snapshot.data!.docs[index].data().imageUrl!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
      ),
    );
  }

  Widget buildTextInput({
    required BuildContext context,
    required VoidCallback sending,
    required VoidCallback? sendingImage,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      //expands: tru
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colord.whit,
          hintText: "Write Here".tr(context),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.paperclip,
                  size: 20,
                  color: Colord.blackOpacity,
                ),
                color: Colors.black,
                onPressed: () {
                  sendingImage!();
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.paperPlane),
                color: Colors.black,
                onPressed: () {
                  sending();
                  controller.clear();
                },
              ),
            ],
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colord.blackOpacity),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colord.blackOpacity))),
    );
  }
}
