import 'package:flutter/material.dart';

import '../colors/my_color.dart';

class SharedLeading extends StatelessWidget {
  SharedLeading({super.key, this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            alignment: Alignment.center,
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Colord.whit, width: 1),
              borderRadius: BorderRadius.circular(35),
            ),
            child: IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                onPressed: onPressed,
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );

    // Row(
    //   children: [
    //     const SizedBox(
    //       width: 25,
    //     ),
    //     CircleAvatar(
    //       backgroundColor: Colors.white,
    //       radius: 19,
    //       child: CircleAvatar(
    //         backgroundColor: Colord.mainColor,
    //         radius: 18,
    //         child: IconButton(
    //           onPressed: () {},
    //           icon: const FaIcon(
    //             FontAwesomeIcons.bell,
    //             color: Colord.whit,
    //             size: 25,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
