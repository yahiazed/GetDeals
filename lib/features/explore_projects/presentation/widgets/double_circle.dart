// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class SharedCircleWhite extends StatelessWidget {
  String txtTop;
  String txtDown;

  SharedCircleWhite({
    Key? key,
    required this.txtTop,
    required this.txtDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 91,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colord.whit,
          ),
          borderRadius: BorderRadius.circular(90)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            txtTop,
            style: detail414whiteText(),
          ),
          Text(
            txtDown,
            textAlign: TextAlign.center,
            style: txt714white(),
          ),
        ],
      ),
    );
  }
}
