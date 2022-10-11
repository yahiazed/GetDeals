// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SharedCard extends StatelessWidget {
  VoidCallback onPressed;
  IconData icon;
  SharedCard({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98,
      height: 59,
      color: Colors.transparent,
      child: Card(
          elevation: 3,
          color: Colors.white.withOpacity(0.99),
          margin: EdgeInsets.zero,
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          )),
    );
  }
}
