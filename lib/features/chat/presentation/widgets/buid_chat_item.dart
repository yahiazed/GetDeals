// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class SharedChatItem extends StatelessWidget {
  String img;
  String personName;
  String msg;
  String date;
  VoidCallback onPressed;

  SharedChatItem({
    Key? key,
    required this.img,
    required this.personName,
    required this.msg,
    required this.date,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            ListTile(
              leading:
                  CircleAvatar(radius: 25, backgroundImage: NetworkImage(img)),
              title: Text(
                personName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: head520BlackLine(),
              ),
              subtitle: Text(
                msg,
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style: txt413Black(),
              ),
              trailing: Text(
                date,
                style: hint414blackOpacityText(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colord.blackOpacity2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
