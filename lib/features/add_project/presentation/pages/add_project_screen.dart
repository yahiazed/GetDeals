import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/elevated_button.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/shared_dropdown.dart';
import '../../../../core/utiles/shared_widget/shared_rounded_input.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../explore_projects/presentation/widgets/double_circle.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/add_project_cubit.dart';

class AddProjectScreen extends StatelessWidget {
  UserModel user;
  AddProjectScreen({super.key, required this.user});
  var projectNameController = TextEditingController();
  var projectStateController = TextEditingController();
  var projectPlaceController = TextEditingController();
  var projectDurationController = TextEditingController();
  var projectNumberPartnerController = TextEditingController();
  var projectReasonPayController = TextEditingController();
  var projectSumSalesController = TextEditingController();
  var projectSubnetProfitController = TextEditingController();
  var projectNeededMoneyController = TextEditingController();
  var projectDescriptionController = TextEditingController();
  var addProjectFormKey = GlobalKey<FormState>();
  var nController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // showAlert(context);
    final Size size = MediaQuery.of(context).size;
    int i = 0;
    print(i++);
    return BlocProvider(
      create: (context) => AddProjectCubit(),
      child: BlocConsumer<AddProjectCubit, AddProjectState>(
        listener: (context, state) {
          if (state is StartAddingNewProjectState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colord.barrier,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is SuccessAddNewProjectState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierColor: Colord.barrier,
              builder: (context) => Center(
                child: Container(
                  width: size.width * .90,
                  height: 385,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colord.whit),
                    borderRadius: BorderRadius.circular(41),
                  ),
                  child: Column(
                    children: [
                      //810810mrme$$
                      const Icon(
                        Icons.add_task,
                        size: 128,
                        color: Colord.mGrey,
                      ),
                      DefaultTextStyle(
                        style: t427WhiteText(),
                        child: Text(
                          'Project Send Successfully'.tr(context),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextStyle(
                        style: t420WhiteText(),
                        child: Text(
                          'Our team is currently reviewing your application and you will be notified upon acceptance'
                              .tr(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ErrorAddNewProjectState) {
            Navigator.pop(context);
            CustomSnackBar()
                .showErrorSnackBar(message: state.errMsg, context: context);
          }
        },
        builder: (context, state) {
          var cubit = AddProjectCubit.get(context);
          cubit.user = user;
          return Container(
            decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colord.mainColor,
                centerTitle: true,
                title: SharedTitle(
                  txt: "Add Project".tr(context),
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
                          style: txt520whiteTitle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: Form(
                key: addProjectFormKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SharedBorderInput(
                                hintTxt: "Project Name",
                                controller: projectNameController,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedDropdown(
                                  lable: "Project Type".tr(context),
                                  values: const [
                                    'Applications',
                                    'E-Commerce',
                                    'Factories',
                                    'Shops',
                                    'Franchise',
                                    'Commercial records',
                                    'Companies'
                                  ],
                                  onChanged: (p0) {
                                    cubit.onChanged(p0!);
                                  },
                                  dropdownValue: cubit.projectKind),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Project State",
                                controller: projectStateController,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "region",
                                controller: projectPlaceController,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Duration",
                                controller: projectDurationController,
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "number of partners",
                                controller: projectNumberPartnerController,
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Reason for selling",
                                controller: projectReasonPayController,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Total sales",
                                controller: projectSumSalesController,
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Net profit",
                                controller: projectSubnetProfitController,
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SharedBorderInput(
                                hintTxt: "Project Description",
                                controller: projectDescriptionController,
                                textInputType: TextInputType.multiline,
                                height: 121,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SharedImageUpload(
                                    // cubit: cubit,
                                    txt: 'Add File',
                                    color: cubit.pickedFilesList.isEmpty
                                        ? null
                                        : Colord.mainColor,
                                    widget: cubit.pickedFilesList.isEmpty
                                        ? null
                                        : ListView.builder(
                                            itemCount:
                                                cubit.pickedFilesList.length,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                child: Text(
                                                  cubit.pickedFilesList[index]
                                                      .name,
                                                  style: txt414White1(),
                                                ),
                                              ),
                                            ),
                                          ),
                                    onPressed: () {
                                      cubit.selectFiles();
                                    },
                                  ),
                                  SharedImageUpload(
                                    // cubit: cubit,
                                    txt: 'Add Photo',
                                    widget: cubit.pickedImagesList.isEmpty
                                        ? null
                                        : GridView.builder(
                                            itemCount:
                                                cubit.pickedImagesList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2),
                                            itemBuilder: (context, index) =>
                                                Image.file(
                                              File(cubit.pickedImagesList[index]
                                                  .path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    onPressed: () {
                                      cubit.selectImage();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SharedElevatedButton(
                      width: size.width,
                      height: 100,
                      txt: "next",
                      // color: cubit.pickedFilesList.isEmpty
                      //     ? Colors.transparent
                      //     : Colord.mainColor,

                      onPressed: cubit.pickedImagesList.isNotEmpty
                          ? () {
                              if (addProjectFormKey.currentState!.validate()) {
                                // navigateTo(context, PaymentScreen());
                                cubit.AddingNewProject(
                                    projectName: projectNameController.text,
                                    projectState: projectStateController.text,
                                    projectPlace: projectPlaceController.text,
                                    projectDuration:
                                        projectDurationController.text,
                                    projectPartnerNumber:
                                        projectNumberPartnerController.text,
                                    projectReasonOfPay:
                                        projectReasonPayController.text,
                                    projectSumSales:
                                        projectSumSalesController.text,
                                    projectSubnetProfit:
                                        projectSubnetProfitController.text,
                                    projectDescription:
                                        projectDescriptionController.text);
                              }
                            }
                          : () {
                              print('object......' +
                                  cubit.pickedFilesList.toString());
                              cubit.pickedFilesList
                                  .toString()
                                  .split(',')
                                  .forEach((element) {
                                print('object.....' + element);
                              });
                              CustomSnackBar().showErrorSnackBar(
                                  message: 'Fill All Fields And Attachments',
                                  context: context);
                            },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
