import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../../main.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../explore_projects/presentation/pages/project_details.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../../register/presentation/widgets/generated_row.dart';
import '../cubit/edit_profile_cubit.dart';

class EditProfile extends StatelessWidget {
  UserModel user;
  EditProfile({super.key, required this.user});
  var updateFormKey = GlobalKey<FormState>();
  var scaffoldFormKey = GlobalKey<ScaffoldState>();
  String nameController = '';
  String ageController = '';
  String specializeController = '';
  int yearsController = 0;
  String ServiceDescriptionController = '';
  String ServiceKindController = '';

  String genderController = '';
  String emailController = '';
  String cityController = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is StartUpdateProfileDataState) {
            showDialog(
              context: context,
              barrierColor: Colord.barrier,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }
          // if (state is EndUpdateProfileDataState) {
          //   Navigator.pop(context);
          // }
          if (state is SuccessUpdateState) {
            Navigator.pop(context);
            CustomSnackBar().showSuccessSnackBar(
                message: 'done Successfully', context: context);
            Restart.restartApp();
          }
          if (state is ErrorUpdateProfileState) {
            Navigator.pop(context);
            CustomSnackBar().showErrorSnackBar(
                message: 'Some Thing Went Wrong', context: context);
          }
        },
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);
          cubit.user = user;

          cubit.selectedInterests = user.interests!.split(' ').toList();
          return Container(
            decoration: const BoxDecoration(
                color: Colord.whit,
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              key: scaffoldFormKey,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colord.mainColor,
                centerTitle: true,
                title: SharedTitle(
                  txt: "Edit Profile".tr(context),
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
                          'أهلا.${user.name} ',
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
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.selectImage();
                          },
                          child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colord.mGrey,
                              child: cubit.pickedFile == null
                                  ? CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colord.whit,
                                      backgroundImage:
                                          NetworkImage(user.photo!),
                                    )
                                  : CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colord.whit,
                                      backgroundImage: FileImage(
                                          File(cubit.pickedFile!.path!)),
                                    )),
                        ),
                        Text(
                          user.name,
                          style: txt528BlackText(),
                        ),
                        Text(
                          user.city,
                          style: txtLocation416greenText(),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: updateFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GeneratedRowInputs1(
                              initialValue1: user.name,
                              onChanged: (p0) {
                                nameController = p0;
                              },
                              initialValue2: user.age.toString(),
                              onChanged2: (p0) {
                                ageController = p0;
                              },
                              hint1: "Name",
                              hint2: "Age",
                              textInputType1: TextInputType.name,
                              textInputType2: TextInputType.number),
                          // GeneratedRowInputs(
                          //   controller1: phoneController,
                          //   controller2: genderController,
                          //   hint1: "phone",
                          //   hint2: "Gender",
                          //   textInputType1: TextInputType.none,
                          //   textInputType2: TextInputType.none,
                          //   onTap2: () => showDialog(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //       title: Text('Gender'.tr(context)),
                          //       actions: [
                          //         TextButton(
                          //             onPressed: () {
                          //               cubit.gender = 'male';
                          //               genderController.text =
                          //                   'male'.tr(context);
                          //               Navigator.pop(context);
                          //             },
                          //             child: Text('male'.tr(context))),
                          //         TextButton(
                          //             onPressed: () {
                          //               cubit.gender = 'female';
                          //               genderController.text =
                          //                   'female'.tr(context);
                          //               Navigator.pop(context);
                          //             },
                          //             child: Text('female'.tr(context))),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          GeneratedRowInputs1(
                              initialValue1: user.email,
                              onChanged: (p0) {
                                emailController = p0;
                              },
                              initialValue2: user.city,
                              onChanged2: (p0) {
                                cityController = p0;
                              },
                              hint1: "Email",
                              hint2: "City",
                              textInputType1: TextInputType.emailAddress,
                              textInputType2: TextInputType.text),

                          if (cubit.user.userKind == 0)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 34.0),
                              child: MultiSelectDialogField(
                                barrierColor:
                                    const Color(0xff160048).withOpacity(0.73),
                                buttonIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                buttonText: Text(
                                  "Interests".tr(context),
                                  style: hint414blackOpacityText(),
                                ),
                                itemsTextStyle: hint414blackOpacityText(),
                                items: cubit.interests
                                    .map((e) =>
                                        MultiSelectItem(e, e.tr(context)))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                onConfirm: (values) {
                                  cubit.selectedInterests = values;
                                },
                              ),
                            ),
                          if (cubit.user.userKind == 1)
                            GeneratedRowInputs1(
                                initialValue1: user.specialist,
                                onChanged: (p0) {
                                  specializeController = p0;
                                },
                                initialValue2: user.experienceYears.toString(),
                                onChanged2: (p0) {
                                  yearsController = int.parse(p0);
                                },
                                hint1: "Specialization",
                                hint2: "Experience Years",
                                textInputType1: TextInputType.name,
                                textInputType2: TextInputType.number),
                          if (cubit.user.userKind == 1)
                            buildExperienceDescriptionInputField(
                                ServiceDescriptionController,
                                context,
                                user.serviceDescription!),

                          const SizedBox(
                            height: 38,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 34.0),
                            child: SharedOutlineButton(
                              onPressed: () {
                                cubit.updateProfile(
                                    nameController: nameController == ''
                                        ? user.name
                                        : nameController,
                                    emailController: emailController == ''
                                        ? user.email
                                        : emailController,
                                    genderController: genderController == ''
                                        ? user.gender
                                        : genderController,
                                    cityController: cityController == ''
                                        ? user.city
                                        : cityController,
                                    ageController: int.parse(
                                      ageController == ''
                                          ? user.age.toString()
                                          : ageController,
                                    ),
                                    ServiceDescriptionController:
                                        ServiceDescriptionController == ''
                                            ? user.serviceDescription
                                            : ServiceDescriptionController,
                                    specializeController:
                                        specializeController == ''
                                            ? user.specialist
                                            : specializeController,
                                    yearsController: yearsController == ''
                                        ? user.experienceYears.toString()
                                        : yearsController.toString(),
                                    context: context);
                              },
                              txt: "Save",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Row(
                      children: [
                        Text(
                          "My Projects".tr(context),
                          style: head520BlackLine(),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),

                  //list of advertise banner
                  FirestoreQueryBuilder(
                      query: FirebaseFirestore.instance
                          .collection('projects')
                          .where('userUid', isEqualTo: user.uid)
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
                                                user: user,
                                                projectId:
                                                    snapshot.docs[index].id,
                                              ));
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
          );
        },
      ),
    );
  }

  Container buildExperienceDescriptionInputField(
      String ServiceDescriptionController,
      BuildContext context,
      String initialValue) {
    return Container(
        height: 121,
        margin: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colord.blackOpacity2),
          borderRadius: const BorderRadius.all(Radius.circular(21)),
        ),
        width: double.infinity,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'require';
            }
            return null;
          },
          initialValue: initialValue,
          onChanged: (value) {
            ServiceKindController = value;
          },
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.start,
          maxLines: 6,
          minLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(200)],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Kind Of Service Provider'.tr(context),
            hintStyle: hint414blackOpacityText(),
          ),
        ));
  }
}
