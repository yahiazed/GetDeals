import 'package:flutter/material.dart';

class SharedMainActionDrawer extends StatelessWidget {
  const SharedMainActionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child:

                      // const Center(
                      //     child: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.black,
                      // )

                      Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 20,
                          height: 3,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: 25,
                          height: 3,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: 15,
                          height: 3,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
