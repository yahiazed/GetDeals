import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../colors/my_color.dart';
import '../styles/text_style.dart';

class InputField extends StatelessWidget {
  String hintTxt;
  TextEditingController controller;
  TextInputType textInputType;
  Widget? sufix;
  VoidCallback? onTap;
  String? labelText;
  bool isTrans = true;
  String? initialValue;
  void Function(String)? onChanged;

  InputField(
      {super.key,
      required this.hintTxt,
      required this.controller,
      required this.textInputType,
      this.onTap,
      this.labelText,
      this.initialValue,
      this.isTrans = true,
      this.onChanged,
      this.sufix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return 'required';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: sufix,
        labelText: labelText,
        labelStyle: hint414blackOpacityText(),
        suffixIconColor: Colord.bla,
        hintText: isTrans ? hintTxt.tr(context) : hintTxt,
        hintStyle: hint414blackOpacityText(),
      ),
    );
  }
}

class InputField1 extends StatelessWidget {
  String hintTxt;
  TextEditingController? controller;
  TextInputType textInputType;
  Widget? sufix;
  VoidCallback? onTap;
  String? labelText;
  bool isTrans = true;
  String? initialValue;
  String? newValue;
  void Function(String)? onChanged;

  InputField1(
      {super.key,
      required this.hintTxt,
      this.controller,
      required this.textInputType,
      this.onTap,
      this.labelText,
      this.initialValue,
      this.newValue,
      this.isTrans = true,
      this.onChanged,
      this.sufix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return 'required';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: sufix,
        labelText: labelText,
        labelStyle: hint414blackOpacityText(),
        suffixIconColor: Colord.bla,
        hintText: isTrans ? hintTxt.tr(context) : hintTxt,
        hintStyle: hint414blackOpacityText(),
      ),
    );
  }
}
