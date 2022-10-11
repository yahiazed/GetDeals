import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DoubleBorder extends StatelessWidget {
  double r1, r2, r3;
  String img;
  DoubleBorder(
      {super.key,
      required this.r1,
      required this.r2,
      required this.r3,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: r1,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: r2,
        backgroundColor: const Color(0xff160048),
        child: CircleAvatar(
          radius: r3,
          backgroundColor: Colors.white,
          child: ClipOval(
              child: CachedNetworkImage(
            width: 43,
            height: 42,
            colorBlendMode: BlendMode.dstATop,
            imageUrl: img,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )

              //      Image.network(
              //   img,
              //   color: null,
              //   fit: BoxFit.cover,
              //   width: 43.0,
              //   height: 42.0,
              //   colorBlendMode: BlendMode.dstATop,
              // )
              ),
        ),
      ),
    );
  }
}
