import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/features/add_project/domain/post_model.dart';
import 'package:getdealss/features/explore_projects/presentation/pages/project_details.dart';
import 'package:getdealss/features/register/domain/entities/user_model.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/elevated_button.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/shared_rounded_input.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';

class LatestOperations extends StatelessWidget {
  UserModel user;
  LatestOperations({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var cardNumberController = TextEditingController();
    return Container(
        decoration: const BoxDecoration(
            color: Colord.whit,
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colord.mainColor,
              centerTitle: true,
              title: SharedTitle(
                txt: "Latest Operations".tr(context),
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
                        img: user.photo!,
                      ),
                      title: Text(
                        'أهلا. ${user.name} ',
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
            body: FirestoreQueryBuilder<ProjectModel>(
              query: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('explore')
                  .withConverter<ProjectModel>(
                    fromFirestore: (snapshot, _) =>
                        ProjectModel.fromJson(snapshot.data()!),
                    toFirestore: (model, _) => model.toJson(),
                  ),
              pageSize: 15,
              builder: (context, snapshot, child) => ListView.separated(
                  itemBuilder: (context, index) {
                    if (snapshot.isFetching) {
                      Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.docs.isEmpty) {
                      return Text(
                        'No Project You Expolre Yet!!'.tr(context),
                        style: tProjectName724BlackText(),
                      );
                    }
                    final project = snapshot.docs[index].data();
                    return GestureDetector(
                      onTap: () {
                        navigateTo(context,
                            ProjectDetailsScreen(project: project, user: user));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            project.imgUrls.split(',').first,
                          ),
                        ),
                        title: Text(
                          project.projectName,
                          style: txt418blackText(),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.projectPlace,
                              style: txt413Black(),
                            ),
                            Text(
                              project.projectSumSales,
                              style: txt413Black(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                      ),
                  itemCount: snapshot.docs.length),
            )));
  }
}
