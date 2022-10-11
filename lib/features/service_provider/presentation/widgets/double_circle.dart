// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class DoubleCirclePer extends StatelessWidget {
  String txtTop;
  String txtDown;
  TextStyle? textStyle1;
  TextStyle? textStyle2;

  DoubleCirclePer({
    Key? key,
    required this.txtTop,
    required this.txtDown,
    this.textStyle1,
    this.textStyle2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 107,
      height: 111,
      child: CircleAvatar(
        backgroundColor: Colord.main2,
        child: Container(
          width: 89,
          height: 92,
          child: CircleAvatar(
            backgroundColor: Colord.main3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  txtTop,
                  style: textStyle1 ?? t427WhiteText(),
                ),
                Text(
                  txtDown,
                  textAlign: TextAlign.center,
                  style: textStyle2 ?? txt713White(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoubleCirclePer1 extends StatelessWidget {
  String txtTop;
  String txtDown;
  TextStyle? textStyle1;
  TextStyle? textStyle2;

  DoubleCirclePer1({
    Key? key,
    required this.txtTop,
    required this.txtDown,
    this.textStyle1,
    this.textStyle2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 107,
      height: 111,
      decoration: BoxDecoration(color: Colord.main2, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: 89,
          height: 92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colord.main3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  txtTop,
                  style: textStyle1 ?? t427WhiteText(),
                ),
              ),
              FittedBox(
                child: Text(
                  txtDown,
                  textAlign: TextAlign.center,
                  style: textStyle2 ?? txt713White(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
