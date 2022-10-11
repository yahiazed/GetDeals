// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../colors/my_color.dart';
import '../styles/text_style.dart';

class SharedBorderInput extends StatelessWidget {
  String hintTxt;
  TextEditingController controller;
  TextInputType textInputType;
  Widget? sufix;
  double? height;
  double? radius;
  TextAlign? textAlign;
  void Function()? onTap;
  bool errorTextPresent = true;
  SharedBorderInput(
      {Key? key,
      required this.hintTxt,
      required this.controller,
      required this.textInputType,
      this.sufix,
      this.onTap,
      this.height,
      this.radius,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 50,
        decoration: BoxDecoration(
            // boxShadow: [
            //   if (height == null)
            //     BoxShadow(
            //       color: Colors.black.withOpacity(.32),
            //       blurRadius: 1.0,
            //       spreadRadius: -20,
            //       offset: const Offset(0, 27),
            //     ),
            //   if (height == 121)
            //     BoxShadow(
            //       color: Colors.black.withOpacity(.32),
            //       blurRadius: 1.0,
            //       spreadRadius: -59,
            //       offset: const Offset(0, 62),
            //     ),
            // ],
            // borderRadius: BorderRadius.all(Radius.circular(radius ?? 21)),
            // border: Border.all(width: 1, color: Colord.blackOpacity2),
            ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Require';
            }
            return null;
          },
          controller: controller,
          onTap: onTap,
          textAlign: textAlign ?? TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: textInputType,
          maxLines: height != null ? 5 : 1,
          decoration: InputDecoration(
            isDense: true,
            errorStyle: TextStyle(
              fontSize: 5,
            ),
            suffix: sufix,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            suffixIcon: sufix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 21)),
              borderSide: BorderSide(width: 1, color: Colord.blackOpacity2),
            ),
            hintText: hintTxt.tr(context),
            hintStyle: hint414blackOpacityText(),
          ),
        ));
  }
}

// ignore: must_be_immutable
class SharedImageUpload extends StatelessWidget {
  VoidCallback onPressed;
  String txt;

  Color? color;
  Widget? widget;
  SharedImageUpload({
    Key? key,
    required this.onPressed,
    required this.txt,
    this.color,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 98,
            height: 96,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(21)),
                border: Border.all(width: 1, color: Colord.blackOpacity)),
            child: widget ??
                Center(
                    child: Icon(
                  Icons.attach_file_rounded,
                  size: 50,
                  color: Colord.mGrey,
                )),
          ),
          Text(
            txt.tr(context),
            style: hint414blackOpacityText(),
          )
        ],
      ),
    );
  }
}
