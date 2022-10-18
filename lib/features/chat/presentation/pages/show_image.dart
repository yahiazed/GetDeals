import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowSendImage extends StatelessWidget {
  String img;
  ShowSendImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
