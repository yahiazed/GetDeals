import 'package:flutter/material.dart';

class SharedAction extends StatelessWidget {
  const SharedAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 66.0,
            height: 35.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(0.0),
                topStart: Radius.circular(16.0),
                bottomStart: Radius.circular(16.0),
                bottomEnd: Radius.circular(0.0),
              ),
            ),
            child: IconButton(
              iconSize: 20,
              color: Colors.black,
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )

            //  Padding(
            //     padding: const EdgeInsets.all(7),
            //     child: Container(
            //       child: const Center(
            //           child: Icon(
            //         Icons.arrow_forward_ios,
            //         color: Colors.black,
            //       )

            //           // Column(
            //           //   crossAxisAlignment: CrossAxisAlignment.end,
            //           //   children: [
            //           //     Container(
            //           //       width: 20,
            //           //       height: 3,
            //           //       color: Colors.grey,
            //           //     ),
            //           //     const SizedBox(
            //           //       height: 3,
            //           //     ),
            //           //     Container(
            //           //       width: 25,
            //           //       height: 3,
            //           //       color: Colors.grey,
            //           //     ),
            //           //     const SizedBox(
            //           //       height: 3,
            //           //     ),
            //           //     Container(
            //           //       width: 15,
            //           //       height: 3,
            //           //       color: Colors.grey,
            //           //     ),
            //           //   ],
            //           // ),

            //           ),
            //     )

            //     // Image.asset(
            //     //   "assets/images/1390b761b1e09478520fa21729678a07e906687a.png",
            //     //   fit: BoxFit.contain,
            //     //   colorBlendMode: BlendMode.dstATop,
            //     // ),
            //     ),
            ),
      ],
    );
  }
}
