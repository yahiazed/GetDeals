// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../main.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../../../main_home/presentation/pages/main_home_screen.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../../register/presentation/pages/register_screen.dart';

class SplashScreen extends StatefulWidget {
  Widget widget;
  UserModel? user;
  SplashScreen({
    super.key,
    required this.widget,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigateToHome() async {
    // await Future.delayed(
    //   Duration(
    //     milliseconds: 1500,
    //   ),
    //   () {},
    // );
    await Firebase.initializeApp();
    await getUserData();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.widget,
        ));
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colord.mainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Image.asset('assets/images/log.png', color: Colord.whit),
        ),
      ),
    );
  }

  Future getUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final modelRef = FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );
      widget.user = await modelRef.get().then((value) => value.data()!);
      if (widget.user!.userKind == 1) {
        final modelRef = FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJsonServiceProvider(snapshot.data()!),
              toFirestore: (model, _) => model.toJsonServiceProvider(),
            );
        widget.user = await modelRef.get().then((value) => value.data()!);
      }
      widget.widget = MainHomeScreen(user: widget.user!);
    } else {
      widget.widget = RegisterScreen();
    }
  }
}
