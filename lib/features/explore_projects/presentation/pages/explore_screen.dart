import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/core/utiles/styles/text_style.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/explore_projects_cubit.dart';
import '../widgets/double_circle.dart';
import '../widgets/explor_stack_body.dart';

class ExploreScreen extends StatelessWidget {
  UserModel user;
  ExploreScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<ExploreProjectsCubit, ExploreProjectsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ExploreProjectsCubit.get(context);
        final query = FirebaseFirestore.instance
            .collection('projects')
            .orderBy('projectDate', descending: true)
            .withConverter<ProjectModel>(
              fromFirestore: (snapshot, _) =>
                  ProjectModel.fromJson(snapshot.data()!),
              toFirestore: (project, _) => project.toJson(),
            );
        return FirestoreQueryBuilder<ProjectModel>(
          query: query,
          pageSize: 10,
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Some Thing Wrong',
                style: t4420BlackText(),
              ));
            } else {
              return PageView.builder(
                itemBuilder: (context, index) {
                  final hasEndReached = snapshot.hasMore &&
                      index + 1 == snapshot.docs.length &&
                      !snapshot.isFetchingMore;
                  if (hasEndReached) {
                    snapshot.fetchMore();
                  }
                  final project = snapshot.docs[index].data();
                  final projectId = snapshot.docs[index].id;

                  return BodyStack(
                    project: project,
                    user: user,
                    projectId: projectId,
                  );
                },
                itemCount: snapshot.docs.length,
                scrollDirection: Axis.vertical,
              );
            }
          },
        );
      },
    );
  }

  Stack buildPageItem(BuildContext context, Size size) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => showAlert(context),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://www.figma.com/file/F05Jr8VAl6Ne2NdQHel0ev/image/f5b23a50be6e1b62d9ed73a67115405844bebdae?fuid=1143301923436518477',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Container(
            //height: 200,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "مقهى البنالعربي",
                    style: txt724WhiteText(),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: 150,
                      child: SharedOutlineButton(
                        borderColor: Colord.whit,
                        txtStyle: txt414White(),
                        paddingHorizontal: 20,
                        radius: 25,
                        onPressed: () {
                          print('object,,,,');
                        },
                        txt: "more",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void showAlert(context) {
    final Size size = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      elevation: 2,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: size.width,
        height: size.height * 0.40,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
                SharedCircleWhite(txtTop: "مشروع قائم", txtDown: 'النوع'),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 32),
              child: Container(
                  //height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colord.whit),
                      borderRadius: BorderRadius.all(Radius.circular(42))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: "Reason of sell".tr(context),
                            style: txt714white(),
                            children: [
                              TextSpan(
                                text: "توسعة المحل وفتح فروع",
                                style: detail414whiteText(),
                              )
                            ])),
                  )

                  // ,Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Reason of pay",
                  //       maxLines: 2,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: detail714whiteText(),
                  //     ),
                  //     Text(
                  //       "Reason of paynnnnnnnnnnnnnmkmimipl;l,oijijh7yf5aedxda",
                  //       maxLines: 3,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: detail414whiteText(),
                  //     ),
                  //   ],
                  // ),

                  ),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) => alert,
        barrierColor: Colord.barrier);
  }
}
