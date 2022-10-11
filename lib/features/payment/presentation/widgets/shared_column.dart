// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/shared_widget/shared_rounded_input.dart';
import '../../../../core/utiles/styles/text_style.dart';

class SharedColumnDate extends StatelessWidget {
  String txtHead;
  String txtHint;
  TextEditingController controller;
  TextInputType textInputType;
  SharedColumnDate({
    Key? key,
    required this.txtHead,
    required this.txtHint,
    required this.controller,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            txtHead.tr(context),
            style: txt514BlackLine(),
          ),
        ),
        SharedBorderInput(
          height: 48,
          radius: 13,
          hintTxt: txtHint,
          textAlign: TextAlign.center,
          controller: controller,
          textInputType: textInputType,
        ),
      ],
    );
  }
}
