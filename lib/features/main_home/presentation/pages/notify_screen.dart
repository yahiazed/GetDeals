import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/core/utiles/styles/text_style.dart';
import 'package:getdealss/features/main_home/presentation/cubit/main_home_cubit.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../chat/presentation/pages/chat_detail_screen.dart';
import '../../../chat/presentation/widgets/buid_chat_item.dart';
import '../../../explore_projects/domain/messageModel.dart';
import '../../../register/domain/entities/user_model.dart';

class NotifyScreen extends StatelessWidget {
  UserModel user;
  NotifyScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final q = FirebaseFirestore.instance.collection('notifications');
    return BlocConsumer<MainHomeCubit, MainHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainHomeCubit.get(context);
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
              child: Scaffold(
                body: Column(
                  children: [
                    FirestoreQueryBuilder(
                        query: q,
                        builder: (context, snapshot, child) {
                          if (snapshot.isFetching) {
                            return Container(
                                width: double.infinity,
                                height: 200,
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }

                          return Container(
                            height: 600,
                            child: ListView.builder(
                              itemCount: snapshot.docs.length,
                              itemBuilder: (context, index) {
                                //final receiverUser = snapshot.docs[index].data();
                                return ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .docs[index]
                                          .data()['imgUrl'])),
                                  title: Text(
                                    snapshot.docs[index].data()['senderName'],
                                    style: title1(),
                                  ),
                                  subtitle: Text(
                                    snapshot.docs[index].data()['NotifyMsg'],
                                    style: txt413Black(),
                                  ),
                                  trailing: Text(
                                    snapshot.docs[index].data()['time'],
                                    style: txt413Black(),
                                  ),
                                );

                                // Container(
                                //     constraints: BoxConstraints(maxHeight: 200),
                                //     child: Row(
                                //       //crossAxisAlignment: CrossAxisAlignment.start,
                                //       //mainAxisSize: MainAxisSize.min,
                                //       //mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         Container(
                                //           width: 64,
                                //           height: 65,
                                //           decoration: BoxDecoration(
                                //               shape: BoxShape.circle,
                                //               image: DecorationImage(
                                //                   image: NetworkImage(snapshot
                                //                       .docs[index]
                                //                       .data()['imgUrl']))),
                                //         ),
                                //         Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               snapshot.docs[index]
                                //                   .data()['senderName'],
                                //               style: title1(),
                                //             ),
                                //             Text(
                                //               snapshot.docs[index]
                                //                   .data()['NotifyMsg'],
                                //               style: txt413Black(),
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           snapshot.docs[index].data()['time'],
                                //           style: txt413Black(),
                                //         ),
                                //       ],
                                //     ));
                              },
                            ),
                          );
                        })
                  ],
                ),
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