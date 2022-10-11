import 'package:flutter/material.dart';

import '../styles/text_style.dart';

class SharedTitle extends StatelessWidget {
  String txt;
  SharedTitle({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: txt520whiteTitle(),
    );
  }
}
