import 'package:flutter/material.dart';

class NavigationIcon extends StatelessWidget {
  final String imgUrl;
  VoidCallback? onPressed;
  NavigationIcon({super.key, required this.imgUrl, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 28.0,
        height: 28.0,
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.asset(
            imgUrl,
            color: null,
            fit: BoxFit.cover,
            width: 28.0,
            height: 28.0,
            colorBlendMode: BlendMode.dstATop,
          ),
        ),
      ),
    );
    ;
  }
}
