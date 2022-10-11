// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../styles/text_style.dart';

class SharedHeadMore extends StatelessWidget {
  String txtHead;
  VoidCallback? onPressed;
  SharedHeadMore({
    Key? key,
    required this.txtHead,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 0),
      child: Row(
        children: [
          Text(
            txtHead.tr(context),
            style: head520BlackLine(),
          ),
          Spacer(),
          onPressed != null
              ? TextButton(
                  onPressed: onPressed,
                  child: Text(
                    "more".tr(context),
                    style: more414blackText(),
                  ),
                )
              : SizedBox(
                  height: 1,
                  width: 1,
                ),
        ],
      ),
    );
  }
}
