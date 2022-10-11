import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../add_project/domain/post_model.dart';
import '../../../register/domain/entities/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  final List<String> interests = [
    'Applications',
    'E-Commerce',
    'Factories',
    'Shops',
    'Franchise',
    'Commercial records',
    'Companies',
    'serviceProviderTitle'
  ];
  final List<String> interestsIcon = [
    'assets/images/mobile.png',
    'assets/images/website.png',
    'assets/images/fact.png',
    'assets/images/shops.png',
    'assets/images/branch.png',
    'assets/images/note.png',
    'assets/images/company.png',
    'assets/images/freelancer.png',
  ];

  var query;
  var queryBanner;
  var queryForUser;
  getData() {
    emit(StartGetData());
    query = FirebaseFirestore.instance
        .collection('projects')
        .orderBy('projectDate', descending: true)
        .withConverter<ProjectModel>(
          fromFirestore: (snapshot, _) =>
              ProjectModel.fromJson(snapshot.data()!),
          toFirestore: (project, _) => project.toJson(),
        );
    queryForUser = FirebaseFirestore.instance
        .collection('users')
        .where('userKind', isEqualTo: 1)
//.orderBy('projectDate', descending: true)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJsonServiceProvider(snapshot.data()!),
          toFirestore: (user, _) => user.toJsonServiceProvider(),
        );

    emit(EndGetData());
  }

  getBannerData() {
    emit(StartGetData());
    queryBanner = FirebaseFirestore.instance
        .collection('banners')
        .orderBy('date', descending: true);

    emit(EndGetData());
  }

  // Future sendNotifyToAssem(
  //     {required UserModel sender, required String orderMsg}) async {
  //   emit(StartSendingOrderToOwner());
  //   await FirebaseFirestore.instance.collection('notifyProjects').doc().set({
  //     'senderId': sender.uid,
  //     'senderName': sender.name,
  //     'orderMsg': orderMsg,
  //     'date': DateTime.now(),
  //     'formatDate': DateFormat.yMMMd().format(DateTime.now()),
  //   }).whenComplete(() {
  //     emit(EndSendingOrderToOwner());
  //   });
  // }
}
   // 'assets/images/shops.png',
    // 'assets/images/Franchise.png',
    // 'assets/images/records.png',