import 'package:flutter/material.dart';

class RoundedShape {
  static RoundedRectangleBorder roundedAppBar() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(21),
      bottomRight: Radius.circular(21),
    ));
  }
}
