import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/core/utiles/styles/text_style.dart';

import 'package:intl/intl.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/app_bar_content/shared_action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';

import '../../../add_project/domain/post_model.dart';
import '../../../chat/presentation/pages/chat_screen.dart';
import '../../../explore_projects/domain/messageModel.dart';
import '../../../explore_projects/presentation/pages/explore_screen.dart';
import '../../../home/presentation/pages/home_base_screen.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../../setting/presentation/pages/Setting_screen.dart';
import '../../../admin/admin.dart';
import '../pages/notify_screen.dart';

part 'main_home_state.dart';

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit() : super(MainHomeInitial());
  static MainHomeCubit get(context) => BlocProvider.of(context);
  int pageIndex = 0;
  List<String> titles = ["home", "Available Project", "chats", "Setting"];
  late UserModel userData;
  List<ProjectModel> myProjects = [];

  late List<Widget> screens;
  //  = [
  //   const HomeBaseScreen(),
  //   const ExploreScreen(),
  //   const ChatScreen(),
  //   Settingscreen
  // ];
  void passUserData() async {
    screens = [
      HomeBaseScreen(user: userData),
      ExploreScreen(user: userData),
      ChatScreen(user: userData),
      SettingScreen(user: userData),
    ];
  }

  void changePageIndex(int index) {
    emit(StartChangePageIndexState());
    pageIndex = index;
    emit(ChangePageIndexState());
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // Future <UserModel>getUserData(){
  //   users.doc(Firebase_auth)
  // }
  AppBar exploreAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: SharedLeading(),
      actions: const [SharedMainActionDrawer()],
      title: SharedTitle(txt: "Available Project".tr(context)),
      centerTitle: true,
      elevation: 0,
      leadingWidth: 66.0,
    );
  }

  AppBar mainAppBar({context, width}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colord.mainColor,
      centerTitle: pageIndex == 2 ? false : true,
      elevation: pageIndex == 2 ? 0 : null,
      title: SharedTitle(
        txt: titles[pageIndex].tr(context),
      ),
      leadingWidth: 66.0,
      actions: const [SharedMainActionDrawer()],
      leading: pageIndex == 2
          ? null
          : SharedLeading(
              onPressed: () {
                if (userData.uid == '9B61R11nkBSAWqNt1o3a9EXSJbB3') {
                  navigateTo(context, AdminScreen());
                } else {
                  navigateTo(
                      context,
                      NotifyScreen(
                        user: userData,
                      ));
                }
              },
            ),
      shape: pageIndex == 2 ? null : RoundedShape.roundedAppBar(),
      toolbarHeight: pageIndex == 2 ? 100 : 187,
      bottom: pageIndex == 2
          ? null
          : PreferredSize(
              preferredSize: Size(width, 1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 29.0),
                child: Container(
                  child: ListTile(
                    leading: DoubleBorder(
                        r1: 25, r2: 24, r3: 22, img: '${userData.photo}'),
                    title: Text(
                      'أهلا. ${userData.name} ',
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
    );
  }

  Future sendNotifyToAssem(
      {required UserModel sender,
      required String orderMsg,
      String? collection}) async {
    emit(StartNotifyMessage());
    await FirebaseFirestore.instance
        .collection(collection ?? 'notifyProjects')
        .doc()
        .set({
      'senderId': sender.uid,
      'senderName': sender.name,
      'orderMsg': orderMsg,
      'date': DateTime.now(),
      'formatDate': DateFormat.yMMMd().format(DateTime.now()),
    }).whenComplete(() {
      emit(EndNotifyMessage());
    });
  }

  Future getMyProjects({
    required String userUID,
  }) async {
    myProjects.clear();
    await FirebaseFirestore.instance
        .collection('projects')
        .where('userUid', isEqualTo: userUID)
        .withConverter<ProjectModel>(
          fromFirestore: (snapshot, _) =>
              ProjectModel.fromJson(snapshot.data()!),
          toFirestore: (person, _) => person.toJson(),
        )
        .get()
        .then((value) {
      value.docs.forEach((element) {
        ProjectModel p = element.data();
        myProjects.add(p);
      });
    });
  }
}
