import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/core/utiles/shared_widget/shared_drawer_nav.dart';

import '../../../features/edit_profile/presentation/pages/edit_profile_Screen.dart';
import '../../../features/login/presentation/pages/login_screen.dart';
import '../../../features/register/domain/entities/user_model.dart';
import '../colors/my_color.dart';
import '../styles/text_style.dart';

class SharedDrawer extends StatelessWidget {
  UserModel user;
  SharedDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                  child: Center(
                child: Image.asset(
                  "assets/images/log.png",
                  width: 202,
                  height: 194,
                  color: Colord.mainColor,
                ),
              )),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Main Menu".tr(context),
                  style: txtDrawer620blackText(),
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.home),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      child: Text(
                        'home'.tr(context),
                        style: txtDrawer516TitlesText(),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SharedDrawerNavItem(
                  widget: EditProfile(user: user),
                  txt: "My Projects".tr(context),
                  icon: FontAwesomeIcons.shoppingBag),
              SharedDrawerNavItem(
                  widget: EditProfile(
                    user: user,
                  ),
                  txt: "Latest Operations".tr(context),
                  icon: FontAwesomeIcons.tasks),
              SharedDrawerNavItem(
                  widget: EditProfile(
                    user: user,
                  ),
                  txt: "Edit Profile".tr(context),
                  icon: FontAwesomeIcons.user),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Icon(Icons.logout_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      child: Text(
                        "sign out".tr(context),
                        style: txtDrawer516TitlesText(),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        });
                      },
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Get Deal App",
                      style: txtDrawerbase516TitlesText(),
                    ),
                    Text(
                      'App Version 1.0.0',
                      style: txtDrawer512TitlesText(),
                    ),
                    Container(
                      height: 5,
                      width: 132,
                      color: Color(0xffCBCBCB),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
