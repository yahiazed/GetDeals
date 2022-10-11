import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/buid_chat_item.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  UserModel user;
  ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    final streamQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('userschat');
    //  print(streamQuery);
    print(user.uid);
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
        return Container(
          color: Colord.mainColor,
          child: Container(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26.0, vertical: 26),
                    child: InputField(
                      hintTxt: "searchHere",
                      controller: searchController,
                      textInputType: TextInputType.text,
                      sufix: const Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    // height: 400,
                    child: StreamBuilder(
                      stream: streamQuery.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            itemBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 300,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(snapshot.data!.docs[index].id)
                                      .withConverter<UserModel>(
                                        fromFirestore: (snapshot, options) =>
                                            UserModel.fromJson(
                                                snapshot.data()!),
                                        toFirestore: (value, options) =>
                                            value.toJson(),
                                      )
                                      .get(),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return const Text(
                                        'No Chat Yet!!!',
                                      );
                                    }
                                    final receiverUser = snapshot2.data!.data();
                                    return SharedChatItem(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetailScreen(
                                                  sender: user,
                                                  receiverUID: receiverUser.uid,
                                                  receiverUser: receiverUser,
                                                ),
                                              ));
                                        },
                                        img: receiverUser!.photo!,
                                        personName: receiverUser.name,
                                        msg: snapshot.data!.docs[index]
                                            .data()['lastMessage'],
                                        date: snapshot.data!.docs[index]
                                            .data()['time']);
                                  },
                                );
                              });
                        }
                        return Text('No Chat Yet!!');
                      },
                    ),
                  )),
                ],
              )),
        );
      },
    );
  }
}

/**
 
ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => 
                ),
              


 */