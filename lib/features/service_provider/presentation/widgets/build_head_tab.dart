import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class buildHeadTab extends StatelessWidget {
  String txt;
  VoidCallback onPressed;
  buildHeadTab({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45,
        child: Card(
          elevation: 5,
          color: Colord.whit,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Text(
              txt.tr(context),
              textAlign: TextAlign.center,
              style: txt515BlackLine(),
            ),
          ),
        ),
      ),
    );
  }
}
