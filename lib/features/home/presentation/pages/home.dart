// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/custom_paint/custom_paint.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../widgets/icon_nav.dart';

class HomeSC extends StatelessWidget {
  const HomeSC({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var controller = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
          color: Colord.whit,
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colord.mainColor,
            centerTitle: true,
            title: SharedTitle(
              txt: "home".tr(context),
            ),
            leadingWidth: 66.0,
            actions: const [SharedAction()],
            leading: SharedLeading(),
            shape: RoundedShape.roundedAppBar(),
            toolbarHeight: 187,
            bottom: PreferredSize(
              preferredSize: Size(size.width, 1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 29.0),
                child: Container(
                  child: ListTile(
                    leading: DoubleBorder(
                        r1: 25,
                        r2: 24,
                        r3: 22,
                        img:
                            'https://s3-alpha-sig.figma.com/img/2517/e285/9a5688e467c4ec8e6ff77a499486c683?Expires=1662940800&Signature=Q-skL0wtADH7MAax86iMoNeVbsJyCZfEIknxOw5AHJWOs03QrP4Fsiv4dAIOcRYGYHKBFGzk-KXGFNCksAslVQJj8zZBGHBCwrSWPkCwKFeFpEVQw6LyAjxg0-IJZjfhPjW078hMhF5frj8m0eE7d2SD8iygTjR6TFnETCv2Dm6SOaHPmkoMiQoAS~iaMgh9ykZWUKxdc72NgFswVxSJjciON9YXR0OpXZsrtqXAl27rUVtO1bPHT~CkDKjDb5Q-LxcS4MRQW-21DwBYTo0iUO7nm09VkEjZ9A4KZj7Vyro7Tab8BGEeB7cgCMmIByH9JQ1mQu6rIvcw6dJtrYQD8A__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // search field
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26.0, vertical: 26),
                  child: InputField(
                    hintTxt: "searchHere",
                    controller: controller,
                    textInputType: TextInputType.text,
                    sufix: buildSufix(),
                  ),
                ),
                // list of category
                Container(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CircleAvatar(
                      radius: 59,
                      backgroundColor: Colord.mainColor.withOpacity(0.75),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colord.secondColor.withOpacity(.75),
                      ),
                    ),
                  ),
                ),
                //list of advertise banner
                Container(
                    height: 164,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 163,
                          width: 272,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          child: Image.network(
                            'https://s3-alpha-sig.figma.com/img/4ccd/9eec/cd8b3a5b6d7577bdad168d880b5e9de5?Expires=1662940800&Signature=AOOaosPmZHygy3EgZCl1FbspxrtAoBbeCTgUaCLX8WiBw1E3BWKrt0bNbCMA72SB02Sz7Djml6~h9ApFX~0OV3r5A6ANsR4PwO~paZhCyNlg-9Q9eprUl0RlXUDswarhQVn2vC8mdd1LcWU8gWUf1Q4c0u5vQBR6WRsR6gXtKh0gmdw4sME2pXSINvAEr9G6J7FaqUo5m5lFPUgqsKTzQwFy9Rd9Bhan614wwWTIos-aRfde1-pMTjM1JD2u7mq09MgVx5pfhBDbwJ1ZZlGelsayP-EPKgpVA7AmLk5fijoFrAaBiIs1sjOMx3oRAz45kA29suFqA8yfW2h2oiNUYA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
                // head of recently added
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children: [
                      Text(
                        "recently".tr(context),
                        style: head520BlackLine(),
                      ),
                      Spacer(),
                      Text(
                        "more".tr(context),
                        style: more414blackText(),
                      ),
                    ],
                  ),
                ),
                //list of recently added
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: Container(
                    height: 208,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.5),
                        child: Container(
                          width: 181,
                          height: 208,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colord.bla,
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://s3-alpha-sig.figma.com/img/3d9b/f0ef/4f3dce55257b84b2ae3cc46ca9fb69c4?Expires=1662940800&Signature=gZlfShPla5FjkPgxjWbMb-5kC1~uhlpcA8hHbxGrPUkZQ~DngZda2B8Uizdsov~amphaJD7wyshnm9Ld9eNzyyNYGejHH5vx5yvp9-~0KlH6T8dKiy6Q5pzLNwXvvqV-PSkoytwV3fny2RkQ1w~BHLYQu6sz4mWYGCTF3FEUOvFFZsRy6R5OiCjfp3J4lrXV3R41OOqo6LEX19w9qz52BmF0Ere431~ffz9tSw7Ge1lshqbmnTPhFcwoyhr4EcCc5RZkqKNyzvIkPS7Y1yxzUBxTapAWUh7LcWqD870YGoS4zyxI8S0SvM9aGFgKF6WEihwKvWNV6Y1k~oG7vRlN9w__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
                              ),
                              opacity: 0.75,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "متجر الكتروني",
                                  style: nameMeduim16white(),
                                ),
                                Text(
                                  "المبلغ:5000 ريال",
                                  style: txtMeduim13white(),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                // banner best experiences
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    width: size.width * 0.85,
                    height: 167,
                    decoration: BoxDecoration(
                      color: Colord.thirdColor,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(31),
                        topEnd: Radius.circular(29),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "bestExperiences".tr(context),
                            style: best524whiteText(),
                          ),
                        ),
                        Container(
                          width: size.width * 0.50,
                          child: SharedOutlineButton(
                            txt: "OrderService",
                            txtStyle: txt513whiteText(),
                            borderColor: Colord.whit,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //head of service provider
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children: [
                      Text(
                        "serviceProvider".tr(context),
                        style: head520BlackLine(),
                      ),
                      Spacer(),
                      Text(
                        "more".tr(context),
                        style: more414blackText(),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 556,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: 4,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: 181,
                          height: 208,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colord.bla,
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://s3-alpha-sig.figma.com/img/3d9b/f0ef/4f3dce55257b84b2ae3cc46ca9fb69c4?Expires=1662940800&Signature=gZlfShPla5FjkPgxjWbMb-5kC1~uhlpcA8hHbxGrPUkZQ~DngZda2B8Uizdsov~amphaJD7wyshnm9Ld9eNzyyNYGejHH5vx5yvp9-~0KlH6T8dKiy6Q5pzLNwXvvqV-PSkoytwV3fny2RkQ1w~BHLYQu6sz4mWYGCTF3FEUOvFFZsRy6R5OiCjfp3J4lrXV3R41OOqo6LEX19w9qz52BmF0Ere431~ffz9tSw7Ge1lshqbmnTPhFcwoyhr4EcCc5RZkqKNyzvIkPS7Y1yxzUBxTapAWUh7LcWqD870YGoS4zyxI8S0SvM9aGFgKF6WEihwKvWNV6Y1k~oG7vRlN9w__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
                              ),
                              opacity: 0.75,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "متجر الكتروني",
                                  style: nameMeduim16white(),
                                ),
                                Text(
                                  "المبلغ:5000 ريال",
                                  style: txtMeduim13white(),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  child: Container(
                    height: 65,
                    width: 65,
                    child: FittedBox(
                      child: FloatingActionButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colord.mainColor.withOpacity(0.55),
                          elevation: 0.1,
                          onPressed: () {
                            print('object');
                          },
                          child: NavigationIcon(
                            imgUrl: 'assets/images/plus.png',
                          )),
                    ),
                  ),
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
          )),
    );
  }

  Container buildSufix() {
    return Container(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const FaIcon(
            FontAwesomeIcons.search,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          const FaIcon(
            FontAwesomeIcons.sliders,
            size: 20,
          ),
        ],
      ),
    );
  }
}
