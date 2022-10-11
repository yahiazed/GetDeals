import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../chat/presentation/pages/chat_detail_screen.dart';
import '../../../chat/presentation/widgets/buid_chat_item.dart';
import '../../../explore_projects/presentation/pages/project_details.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/service_provider_cubit.dart';
import '../widgets/build_head_tab.dart';
import '../widgets/double_circle.dart';

class ServiceDetailScreen extends StatelessWidget {
  UserModel serviceProviderData;
  UserModel accessUser;

  ServiceDetailScreen(
      {super.key, required this.serviceProviderData, required this.accessUser});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double rate = 0;
    final streamQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(serviceProviderData.uid)
        .collection('comments');
    return BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ServiceProviderCubit.get(context);
        var commentCotroller = TextEditingController();
        return Container(
          decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colord.mainColor,
              centerTitle: true,
              title: SharedTitle(
                txt: "Service Provider Detail".tr(context),
              ),
              leadingWidth: 66.0,
              actions: const [SharedAction()],
              leading: SharedLeading(),
              shape: RoundedShape.roundedAppBar(),
              toolbarHeight: 187,
              bottom: PreferredSize(
                preferredSize: Size(size.width, 1),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 29.0),
                  child: Container(
                    child: ListTile(
                      leading: DoubleBorder(
                        r1: 25,
                        r2: 24,
                        r3: 22,
                        img: accessUser.photo!,
                      ),
                      title: Text(
                        'أهلا. ${accessUser.name} ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    // height: 340,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      elevation: 6,
                      color: Colord.whit,
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Colord.mGrey,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colord.whit,
                                backgroundImage:
                                    NetworkImage(serviceProviderData.photo!),
                              ),
                            ),
                            Text(
                              serviceProviderData.name,
                              style: txt528BlackText(),
                            ),
                            Text(
                              serviceProviderData.specialist!,
                              style: txtLocation416greenText(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: Text(
                                serviceProviderData.serviceDescription ?? '',
                                style: txtLocation416greenText(),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DoubleCirclePer(
                          txtTop: "${serviceProviderData.hourPrice ?? 0}",
                          txtDown: "Hour Price".tr(context)),
                      DoubleCirclePer(
                          txtTop: "${serviceProviderData.rate ?? 0}",
                          txtDown: "Rate".tr(context)),
                      DoubleCirclePer(
                          txtTop: "${serviceProviderData.experienceYears}",
                          txtDown: "Experience Years".tr(context)),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeadTab(
                        txt: 'Rate',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocConsumer<
                                ServiceProviderCubit, ServiceProviderState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                var controlle = TextEditingController();
                                return AlertDialog(
                                  title: Text(
                                    'Rate'.tr(context),
                                    style: txt520BlackTitle(),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RatingBar.builder(
                                        itemBuilder: (context, index) =>
                                            const Icon(Icons.star,
                                                color: Colors.amber),
                                        onRatingUpdate: (value) {
                                          rate = value;
                                          print(rate);
                                        },
                                      ),
                                      TextFormField(
                                        controller: controlle,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Write Comment....".tr(context),
                                            border: const OutlineInputBorder()),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          cubit.commentServiceProvider(
                                              accessUser: accessUser,
                                              serviceProvider:
                                                  serviceProviderData,
                                              comment: controlle.text,
                                              rate: rate);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ok'.tr(context),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel".tr(context),
                                        )),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      buildHeadTab(
                        txt: "comments",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => BlocConsumer<
                                ServiceProviderCubit, ServiceProviderState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                var controlle = TextEditingController();
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Text(
                                        "comments".tr(context),
                                        style: title1(),
                                      ),
                                    ),
                                    Expanded(
                                      child: StreamBuilder(
                                        stream: streamQuery.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return ListView.builder(
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                width: double.infinity,
                                                height: 250,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircularProgressIndicator();
                                                  }
                                                  return FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .withConverter<
                                                            UserModel>(
                                                          fromFirestore: (snapshot,
                                                                  options) =>
                                                              UserModel.fromJson(
                                                                  snapshot
                                                                      .data()!),
                                                          toFirestore: (value,
                                                                  options) =>
                                                              value.toJson(),
                                                        )
                                                        .get(),
                                                    builder:
                                                        (context, snapshot2) {
                                                      if (snapshot2
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Container();
                                                      } else if (snapshot
                                                          .data!.docs.isEmpty) {
                                                        return const Text(
                                                          'No Chat Yet!!!',
                                                        );
                                                      }
                                                      final receiverUser =
                                                          snapshot2.data!
                                                              .data();
                                                      return ListTile(
                                                        leading: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      receiverUser!
                                                                          .photo!))),
                                                        ),
                                                        title: Text(
                                                          receiverUser.name,
                                                          style:
                                                              txt718greyText(),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .data()['time'],
                                                              style:
                                                                  txt413Black(),
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize: 15,
                                                              initialRating:
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .data()['rate'],
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (value) {
                                                                return null;
                                                              },
                                                            ),
                                                            Text(snapshot.data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'comment'])
                                                          ],
                                                        ),
                                                      );

                                                      // SharedChatItem(
                                                      //     onPressed: () {},
                                                      //     img: receiverUser!.photo!,
                                                      //     personName: receiverUser.name,
                                                      //     msg: snapshot.data!.docs[index]
                                                      //         .data()['comment'],
                                                      //     date: snapshot.data!.docs[index]
                                                      //         .data()['time']);
                                                    },
                                                  );
                                                });
                                          }
                                          return const Text('No Chat Yet!!');
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (serviceProviderData.uid != accessUser.uid)
                    InkWell(
                      onTap: () async {
                        cubit
                            .sendGetDeal1(
                                provider: serviceProviderData,
                                sender: accessUser)
                            .whenComplete(() {
                          navigateTo(
                              context,
                              ChatDetailScreen(
                                sender: accessUser,
                                receiverUID: serviceProviderData.uid,
                              ));
                        });
                      },
                      child: Center(
                        child: Container(
                          width: 107,
                          height: 111,
                          child: CircleAvatar(
                            backgroundColor: Colord.main2,
                            child: Container(
                              width: 89,
                              height: 92,
                              child: CircleAvatar(
                                  backgroundColor: Colord.main3,
                                  child: Image.asset("assets/images/log.png")),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //list of advertise banner
                  FirestoreQueryBuilder(
                      query: FirebaseFirestore.instance
                          .collection('projects')
                          .where('userUid', isEqualTo: serviceProviderData.uid)
                          .withConverter<ProjectModel>(
                            fromFirestore: (snapshot, _) =>
                                ProjectModel.fromJson(snapshot.data()!),
                            toFirestore: (person, _) => person.toJson(),
                          ),
                      builder: (context, snapshot, child) {
                        if (snapshot.isFetching) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.docs.isEmpty) {
                          return Container();
                        }

                        return Container(
                            height: 164,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: snapshot.docs.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  ProjectModel p = snapshot.docs[index].data();
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 163,
                                      width: 272,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      child: InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              ProjectDetailsScreen(
                                                  project: p,
                                                  user: serviceProviderData,
                                                  projectId:
                                                      snapshot.docs[index].id));
                                        },
                                        child: Image.network(
                                          p.imgUrls.split(',').first,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
