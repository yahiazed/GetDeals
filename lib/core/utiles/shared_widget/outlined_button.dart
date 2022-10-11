// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../colors/my_color.dart';
import '../styles/text_style.dart';

class SharedOutlineButton extends StatelessWidget {
  VoidCallback? onPressed;
  VoidCallback? onLongPress;
  ValueChanged<bool>? onHover;
  ValueChanged<bool>? onFocusChange;
  ButtonStyle? style;
  FocusNode? focusNode;
  bool? autofocus = false;
  Clip? clipBehavior = Clip.none;
  String txt;
  Color? borderColor;
  TextStyle? txtStyle;
  double? paddingHorizontal;
  double? radius;
  SharedOutlineButton(
      {required this.txt,
      required this.onPressed,
      this.autofocus,
      this.clipBehavior,
      this.focusNode,
      this.onFocusChange,
      this.onHover,
      this.onLongPress,
      this.paddingHorizontal,
      this.borderColor,
      this.txtStyle,
      this.style,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 34))),
        side: MaterialStateProperty.all(
          BorderSide(
            width: 1,
            color: borderColor ?? Colord.blackOpacity,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          txtStyle ?? more414blackText(),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? 50.0, vertical: 15),
          child: Text(
            txt.tr(context),
            style: txtStyle ?? more414blackText(),
          ),
        ),
      ),
    );
  }
}
