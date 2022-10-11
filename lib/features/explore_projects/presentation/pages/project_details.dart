import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import 'package:intl/intl.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../chat/presentation/pages/chat_detail_screen.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../../service_provider/presentation/widgets/double_circle.dart';
import '../cubit/explore_projects_cubit.dart';

class ProjectDetailsScreen extends StatelessWidget {
  ProjectModel project;
  UserModel user;
  String? projectId;
  ProjectDetailsScreen(
      {super.key, required this.project, required this.user, this.projectId});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var controller = TextEditingController();
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
                txt: "Project Details".tr(context),
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
                          r1: 25, r2: 24, r3: 22, img: user.photo!),
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
            body: BlocConsumer<ExploreProjectsCubit, ExploreProjectsState>(
              listener: (context, state) {
                // if (state is EndSendingGetDealMessage1) {
                //   navigateTo(context, ChatDetailScreen(sender: user));
                // }
              },
              builder: (context, state) {
                var cubit = ExploreProjectsCubit.get(context);

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: size.width,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          height: 265,
                          width: size.width * 0.80,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.23),
                            borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(29),
                              topStart: Radius.circular(29),
                            ),
                          ),
                          child: CarouselSlider(
                            items: List.generate(
                              project.imgUrls.split(',').length,
                              (index) => Image.network(
                                project.imgUrls.split(',')[index],
                                fit: BoxFit.cover,
                                width: size.width * 0.80,
                                height: 265,
                              ),
                            ),
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 1.0,
                              initialPage: 2,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30),
                        child: Text(
                          project.projectName,
                          style: txt724greyText(),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          //height: 248,
                          width: size.width * 0.80,
                          decoration: BoxDecoration(
                              color: Colord.barrier,
                              borderRadius: const BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(29),
                                topEnd: Radius.circular(29),
                              )),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  style: txt413White(),
                                  project.projectDescription)),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          direction: Axis.horizontal,
                          spacing: 15,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            DoubleCirclePer1(
                              txtTop: project.projectKind.tr(context),
                              txtDown: "Project Type".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                            DoubleCirclePer1(
                              txtTop: project.projectDuration,
                              txtDown: "Duration".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                            DoubleCirclePer1(
                              txtTop: project.projectPlace,
                              txtDown: "region".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                            DoubleCirclePer1(
                              txtTop: NumberFormat.compactCurrency(
                                decimalDigits: 2,
                                symbol: '',
                              ).format(int.parse(project.projectSumSales)),
                              txtDown: "Total sales".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                            DoubleCirclePer1(
                              txtTop: NumberFormat.compactCurrency(
                                decimalDigits: 2,
                                symbol: '',
                              ).format(int.parse(project.projectSubnetProfit)),
                              txtDown: "Net profit".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                            DoubleCirclePer1(
                              txtTop: project.projectPartnerNumber,
                              txtDown: "number of partners".tr(context),
                              textStyle1: txt414White(),
                              textStyle2: txt714white(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Container(
                          width: size.width * 0.80,
                          //height: 61,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: Colord.main2,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                width: size.width * 0.75,
                                // height: 50,
                                decoration: BoxDecoration(
                                    color: Colord.main3,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 10),
                                  child: RichText(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: "Reason of sell".tr(context),
                                          style: txt714white(),
                                          children: [
                                            TextSpan(
                                              text: project.projectReasonOfPay,
                                              style: detail414whiteText(),
                                            )
                                          ])),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 73,
                      ),
                      if (project.filesUrls.isNotEmpty)
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Container(
                            height: 265,
                            width: size.width * 0.80,
                            decoration: BoxDecoration(
                                color: Colord.barrier,
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(29),
                                  topStart: Radius.circular(29),
                                )),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: project.filesUrls.split(',').length,
                              itemBuilder: (context, index) => TextButton(
                                onPressed: () async {
                                  await cubit.sendNotification(
                                      senderUser: user,
                                      receiverId: project.userUid,
                                      projectModel: project,
                                      projectId: projectId!,
                                      notifyMsg: 'notifyMsg',
                                      context: context);
                                },
                                child: Text(
                                  project.filesNames.split(',')[index],
                                  style: t420WhiteText(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 73,
                      ),
                      if (user.uid != project.userUid)
                        InkWell(
                          onTap: () async {
                            cubit
                                .sendGetDeal1(project: project, sender: user)
                                .whenComplete(() {});
                            navigateTo(
                                context,
                                ChatDetailScreen(
                                  sender: user,
                                  receiverUID: project.userUid,
                                ));
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
                                      child:
                                          Image.asset("assets/images/log.png")),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            )));
  }
}
