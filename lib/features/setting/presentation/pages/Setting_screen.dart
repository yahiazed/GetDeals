import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/policy_dialog.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../edit_profile/presentation/pages/edit_profile_Screen.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../../../main_home/presentation/cubit/main_home_cubit.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/setting_cubit.dart';
import '../widgets/shared_setting_item.dart';

class SettingScreen extends StatelessWidget {
  UserModel user;
  SettingScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var messageController = TextEditingController();

    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "setting".tr(context),
                    style: tProjectName724BlackText(),
                  ),
                  SharedSettingItem(
                    txt: "My Projects".tr(context),
                    onPressed: () {
                      navigateTo(context, EditProfile(user: user));
                    },
                  ),
                  // SharedSettingItem(
                  //   txt: "change Password".tr(context),
                  //   onPressed: () {},
                  // ),
                  SharedSettingItem(
                    txt: "Edit Profile".tr(context),
                    onPressed: () {
                      navigateTo(
                          context,
                          EditProfile(
                            user: user,
                          ));
                    },
                  ),
                  Text(
                    "termsHead".tr(context),
                    style: tProjectName724BlackText(),
                  ),
                  SharedSettingItem(
                    txt: "Technical support".tr(context),
                    onPressed: () async {
                      showModalBottomSheet(
                          elevation: 15,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) =>
                              BlocConsumer<MainHomeCubit, MainHomeState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  var c = MainHomeCubit.get(context);
                                  var controlle = TextEditingController();
                                  return Container(
                                    width: size.width,
                                    //height: size.height * .50,
                                    decoration: BoxDecoration(
                                      //color: Colord.main2,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          "Contact With Us".tr(context),
                                          style: txt520BlackTitle(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            minLines: 1,
                                            maxLines: 7,
                                            controller: controlle,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            c.sendNotifyToAssem(
                                                orderMsg: controlle.text,
                                                collection: 'support',
                                                sender: user);
                                            controlle.clear();
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34))),
                                            side: MaterialStateProperty.all(
                                              BorderSide(
                                                width: 1,
                                                color: Colord.blackOpacity,
                                              ),
                                            ),
                                            textStyle:
                                                MaterialStateProperty.all(
                                              more414blackText(),
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0,
                                                      vertical: 15),
                                              child: DefaultTextStyle(
                                                style: txt418blackText(),
                                                child: Text(
                                                  'Send'.tr(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ));
                    },
                  ),
                  SharedSettingItem(
                    txt: "Terms and Conditions".tr(context),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            PolicyDialog(mdFile: 'terms_conditions.md'),
                      );
                    },
                  ),
                  SharedSettingItem(
                    txt: "Privacy Policy".tr(context),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            PolicyDialog(mdFile: 'privacy_plocy.md'),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.logout),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "sign out".tr(context),
                            style: t320BlackText(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
