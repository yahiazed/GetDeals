import 'package:flutter/material.dart';

import '../../../../core/utiles/styles/text_style.dart';

class SharedSettingItem extends StatelessWidget {
  VoidCallback onPressed;
  String txt;

  SharedSettingItem({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    txt,
                    style: t320BlackText(),
                  ),
                  Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
