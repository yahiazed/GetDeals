// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../main.dart';
import '../../../login/presentation/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  Widget widget;
  SplashScreen({
    super.key,
    required this.widget,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigateToHome() async {
    await Future.delayed(
      Duration(
        milliseconds: 1500,
      ),
      () {},
    );
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
}
