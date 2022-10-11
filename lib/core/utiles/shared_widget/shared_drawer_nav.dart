import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles/text_style.dart';

class SharedDrawerNavItem extends StatelessWidget {
  Widget widget;
  String txt;
  IconData icon;
  VoidCallback? onPressed;
  SharedDrawerNavItem(
      {super.key,
      required this.widget,
      required this.txt,
      required this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          FaIcon(icon),
          const SizedBox(
            width: 5,
          ),
          TextButton(
            child: Text(
              txt,
              style: txtDrawer516TitlesText(),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget,
                  ));
            },
          )
        ],
      ),
    );
  }
}
