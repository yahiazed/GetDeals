import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getdealss/config/app_localization.dart';

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
  ChatDetailScreen(
      {super.key, required this.sender, this.receiverUID, this.receiverUser});
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var msgController = TextEditingController();

    return BlocConsumer<ChatCubit, ChatState>(
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(sender.uid)
                        .collection('chats')
                        .doc(receiverUID)
                        .collection('message')
                        .orderBy('date', descending: true)
                        .withConverter<MessageModel>(
                          fromFirestore: (snapshot, options) =>
                              MessageModel.fromJson(snapshot.data()!),
                          toFirestore: (value, options) => value.toJson(),
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                bool isMe = snapshot.data!.docs[index]
                                        .data()
                                        .senderId ==
                                    sender.uid;
                                // if (index == snapshot.data!.docs.length) {
                                //   return SizedBox(
                                //     height: 100,
                                //   );
                                // }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: isMe
                                                ? Colord.mainColor
                                                : Colord.main2,
                                            borderRadius: isMe
                                                ? const BorderRadiusDirectional
                                                    .only(
                                                    topStart:
                                                        Radius.circular(1),
                                                    topEnd: Radius.circular(8),
                                                    bottomStart:
                                                        Radius.circular(30),
                                                    bottomEnd:
                                                        Radius.circular(8),
                                                  )
                                                : const BorderRadiusDirectional
                                                    .only(
                                                    topStart:
                                                        Radius.circular(8),
                                                    topEnd: Radius.circular(1),
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
                                            Text(
                                              snapshot.data!.docs[index]
                                                  .data()
                                                  .message,
                                              style: isMe
                                                  ? txt414White()
                                                  : hint414blackOpacityText(),
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
                              }));
                    },
                  ),
                  buildTextInput(
                    context: context,
                    controller: msgController,
                    sending: () {
                      cubit.send(
                          from: sender.uid,
                          to: receiverUID!,
                          message: msgController.text);
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                  )

                  // Container(

                  //   color: Colord.whit,
                  //   width: double.infinity,
                  //   child: SharedBorderInput(
                  //     radius: 0,
                  //     hintTxt: "Write Here",
                  //     height: 61,
                  //     controller: msgController,
                  //     textInputType: TextInputType.multiline,

                  //   ),
                  // ),
                ],
              ),
            ));
      },
    );
  }

  TextFormField buildTextInput({
    required BuildContext context,
    required VoidCallback sending,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      //expands: true,
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
                onPressed: () {},
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
