import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/custom_paint/custom_paint.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/shared_drawer.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/presentation/pages/add_project_screen.dart';
import '../../../home/presentation/widgets/icon_nav.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/main_home_cubit.dart';

class MainHomeScreen extends StatelessWidget {
  UserModel user;

  MainHomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var controller = TextEditingController();
    var cubit = MainHomeCubit.get(context);
    cubit.userData = user;
    cubit.passUserData();
    return BlocConsumer<MainHomeCubit, MainHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
              extendBody: true,
              drawer: SharedDrawer(user: cubit.userData),
              extendBodyBehindAppBar: cubit.pageIndex == 1 ? true : false,
              backgroundColor: Colors.transparent,
              appBar: cubit.pageIndex == 1
                  ? cubit.exploreAppBar(context)
                  : cubit.mainAppBar(context: context, width: size.width),
              body: cubit.screens[cubit.pageIndex],
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
                              backgroundColor:
                                  Colord.mainColor.withOpacity(0.55),
                              elevation: 0.1,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddProjectScreen(user: user),
                                    ));
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
                              cubit.changePageIndex(0);
                            },
                          ),
                          NavigationIcon(
                            imgUrl: 'assets/images/service.png',
                            onPressed: () {
                              cubit.changePageIndex(1);
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.20,
                          ),
                          NavigationIcon(
                            imgUrl: 'assets/images/chat.png',
                            onPressed: () {
                              cubit.changePageIndex(2);
                            },
                          ),
                          NavigationIcon(
                            imgUrl: 'assets/images/user.png',
                            onPressed: () {
                              cubit.changePageIndex(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Container buildSufix() {
    return Container(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          FaIcon(
            FontAwesomeIcons.search,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          FaIcon(
            FontAwesomeIcons.sliders,
            size: 20,
          ),
        ],
      ),
    );
  }
}
