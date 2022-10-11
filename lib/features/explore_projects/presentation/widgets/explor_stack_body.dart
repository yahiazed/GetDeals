import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:intl/intl.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../register/domain/entities/user_model.dart';
import '../pages/project_details.dart';
import 'double_circle.dart';

class BodyStack extends StatelessWidget {
  ProjectModel project;
  UserModel user;
  String? projectId;
  BodyStack(
      {super.key, required this.project, required this.user, this.projectId});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String img = project.imgUrls.split(',').first;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => showAlert(context),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    project.imgUrls.split(',').first,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          bottom: 130,
          left: 0,
          right: 0,
          child: Container(
            //height: 200,
            width: size.width,
            //height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.projectName,
                    style: txt724WhiteText(),
                  ),
                  const SizedBox(
                    height: 30,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailsScreen(
                                  project: project,
                                  user: user,
                                  projectId: projectId,
                                ),
                              ));
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
                SharedCircleWhite(
                    txtTop: project.projectKind.tr(context),
                    txtDown: "Project Type".tr(context)),
                SharedCircleWhite(
                    txtTop: project.projectPlace,
                    txtDown: "region".tr(context)),
                SharedCircleWhite(
                    txtTop: project.projectDuration,
                    txtDown: "Duration".tr(context)),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SharedCircleWhite(
                    txtTop: project.projectPartnerNumber,
                    txtDown: "number of partners".tr(context)),
                SharedCircleWhite(
                    txtTop: NumberFormat.compactCurrency(
                      decimalDigits: 2,
                      symbol: '',
                    ).format(int.parse(project.projectSumSales)),
                    txtDown: "Total sales".tr(context)),
                SharedCircleWhite(
                    txtTop: NumberFormat.compactCurrency(
                      decimalDigits: 2,
                      symbol: '',
                    ).format(int.parse(project.projectSubnetProfit)),
                    txtDown: "Net profit".tr(context)),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 32),
              child: Container(
                  //height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colord.whit),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(42))),
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
                                text: project.projectReasonOfPay,
                                style: detail414whiteText(),
                              )
                            ])),
                  )),
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
