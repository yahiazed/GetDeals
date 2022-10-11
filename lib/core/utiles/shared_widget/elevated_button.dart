// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../colors/my_color.dart';
import '../styles/text_style.dart';

class SharedElevatedButton extends StatelessWidget {
  double width;
  double height;
  String txt;
  void Function()? onPressed;
  Color? color;

  SharedElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.txt,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      // color: Colors.transparent,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(color ?? Colord.mainColor)),
        onPressed: onPressed,
        child: Text(
          txt.tr(context),
          style: txt520whiteTitle(),
        ),
      ),
    );
  }
}
