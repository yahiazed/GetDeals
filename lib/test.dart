// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getdealss/config/app_localization.dart';

import 'core/utiles/colors/my_color.dart';
import 'core/utiles/shared_widget/action.dart';
import 'core/utiles/shared_widget/custom_paint/custom_paint.dart';
import 'core/utiles/shared_widget/input_field.dart';
import 'core/utiles/shared_widget/leading.dart';
import 'core/utiles/shared_widget/shaps.dart';
import 'core/utiles/shared_widget/title.dart';
import 'features/home/presentation/widgets/icon_nav.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colord.mainColor,
          centerTitle: true,
          title: SharedTitle(
            txt: "home".tr(context),
          ),
          leadingWidth: 66.0,
          actions: [const SharedAction()],
          leading: SharedLeading(),
          shape: RoundedShape.roundedAppBar(),
          toolbarHeight: 187,
          bottom: PreferredSize(
            preferredSize: Size(size.width, 1),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 29.0),
              child: Container(
                child: ListTile(
                  leading: doubleBorder(
                      img: "assets/images/bg.png", r1: 25, r2: 24, r3: 22),
                  title: const Text(
                    'أهلا. عبدالله ',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            InputField(
              hintTxt: "searchHere".tr(context),
              controller: searchController,
              textInputType: TextInputType.text,
              sufix: Row(
                children: [],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 100,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/mm.svg',
                  height: 20.0,
                  width: 20.0,
                  colorBlendMode: BlendMode.darken,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
        extendBody:
            true, // Important: to remove background of bottom navigation (making the bar transparent doesn't help)
        bottomNavigationBar: Container(
          height: 90,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size.width, 90),
                painter: BNBCustomPainter(),
              ),
              Center(
                heightFactor: 0.7,
                child: FloatingActionButton(
                    backgroundColor: Colord.mainColor.withOpacity(0.55),
                    elevation: 0.1,
                    onPressed: () {},
                    child: NavigationIcon(
                      imgUrl: 'assets/images/plus.png',
                      onPressed: () {},
                    )),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigationIcon(
                      imgUrl: 'assets/images/home.png',
                      onPressed: () {
                        print('object');
                      },
                    ),
                    NavigationIcon(
                      imgUrl: 'assets/images/service.png',
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: size.width * 0.20,
                    ),
                    NavigationIcon(
                      imgUrl: 'assets/images/chat.png',
                      onPressed: () {},
                    ),
                    NavigationIcon(
                      imgUrl: 'assets/images/user.png',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildIconNav(String img) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        width: 28.0,
        height: 28.0,
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.asset(
            img,
            color: null,
            fit: BoxFit.cover,
            width: 28.0,
            height: 28.0,
            colorBlendMode: BlendMode.dstATop,
          ),
        ),
      ),
    );
  }

  CircleAvatar doubleBorder(
      {required double r1,
      required double r2,
      required double r3,
      required String img}) {
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
              child: Image.asset(
            img,
            color: null,
            fit: BoxFit.cover,
            width: 43.0,
            height: 42.0,
            colorBlendMode: BlendMode.dstATop,
          )),
        ),
      ),
    );
  }
}
