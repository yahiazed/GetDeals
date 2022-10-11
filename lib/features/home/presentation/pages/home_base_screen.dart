import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getdealss/config/app_localization.dart';

import 'package:intl/intl.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/global_head_more.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../explore_projects/presentation/pages/project_details.dart';
import '../../../main_home/presentation/cubit/main_home_cubit.dart';
import '../../../register/domain/entities/user_model.dart';
import '../../../search/presentation/pages/search_screen.dart';
import '../../../search/presentation/widgets/search_suffix.dart';
import '../../../service_provider/presentation/pages/service_provider_explor_screen.dart';
import '../../../service_provider/presentation/widgets/provider_Item.dart';
import '../cubit/home_cubit.dart';
import 'filter_page_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  UserModel user;
  HomeBaseScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var controller = TextEditingController();

    return BlocProvider(
      create: (context) => HomeCubit()
        ..getData()
        ..getBannerData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var controlle = TextEditingController();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // search field
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26.0, vertical: 26),
                  child: InputField(
                    hintTxt: "searchHere",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            user: user,
                          ),
                        )),
                    controller: controller,
                    textInputType: TextInputType.none,
                    sufix: SharedSearchSuffix1(),
                  ),
                ),
                // list of category
                Container(
                    height: 110,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.interests.length,
                      itemBuilder: (context, index) => CircleAvatar(
                        radius: 59,
                        backgroundColor: Colord.mainColor.withOpacity(0.75),
                        child: InkWell(
                          onTap: () => index == 7
                              ? navigateTo(
                                  context, ServiceProviderScreen(user: user))
                              : navigateTo(
                                  context,
                                  FilterScreen(
                                    user: user,
                                    projectKind: cubit.interests[index],
                                  )),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                Colord.secondColor.withOpacity(.75),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    cubit.interestsIcon[index],
                                    width: 37,
                                    height: 37,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    cubit.interests[index].tr(context),
                                    style: txt410White(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                //list of advertise banner

                FirestoreQueryBuilder(
                  query: cubit.queryBanner,
                  pageSize: 4,
                  builder: (context, snapshot, _) {
                    if (snapshot.isFetching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Some Thing Wrong',
                        style: t4420BlackText(),
                      ));
                    } else {
                      return Container(
                        width: double.infinity,
                        height: 210,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.docs.length,
                            itemBuilder: (context, index) {
                              final project = snapshot.docs[index].data();
                              return GestureDetector(
                                onTap: () {
                                  // navigateTo(
                                  //     context,
                                  //     ProjectDetailsScreen(
                                  //         project: project, user: user));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 163,
                                    width: 272,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11))),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          snapshot.docs[index].get('imgUrl'),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),

                                    // , Image.network(
                                    //   snapshot.docs[index].get('imgUrl'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                ),
                              );
                            }),
                      );

                      //  PageView.builder(
                      //   itemBuilder: (context, index) {

                      //     final project = snapshot.docs[index].data();

                      //     return BodyStack(project: project, user: user);
                      //   },
                      //   itemCount: snapshot.docs.length,
                      //   scrollDirection: Axis.vertical,
                      // );
                    }
                  },
                ),

                const SizedBox(
                  height: 26,
                ),
                // head of recently added
                SharedHeadMore(
                  txtHead: "recently",
                  onPressed: () {
                    MainHomeCubit.get(context).changePageIndex(1);
                  },
                ),
                const SizedBox(
                  height: 26,
                ),
                //list of recently added
                FirestoreQueryBuilder<ProjectModel>(
                  query: cubit.query,
                  pageSize: 4,
                  builder: (context, snapshot, _) {
                    if (snapshot.isFetching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Some Thing Wrong',
                        style: t4420BlackText(),
                      ));
                    } else {
                      return Container(
                        width: double.infinity,
                        height: 210,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.docs.length,
                            itemBuilder: (context, index) {
                              final project = snapshot.docs[index].data();
                              return GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      ProjectDetailsScreen(
                                        project: project,
                                        user: user,
                                        projectId: snapshot.docs[index].id,
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9.5),
                                  child: Container(
                                    width: 181,
                                    height: 208,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      color: Colord.bla,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(11),
                                      ),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            project.imgUrls.split(',').first),

                                        //  NetworkImage(
                                        //   project.imgUrls.split(',').first,
                                        // ),
                                        opacity: 0.75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            project.projectName,
                                            style: nameMeduim16white(),
                                          ),
                                          Text(
                                            "قيمة :${NumberFormat.compactCurrency(
                                              decimalDigits: 2,
                                              symbol: '',
                                            ).format(int.parse(project.projectSumSales))} ريال",
                                            style: txtMeduim13white(),
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            }),
                      );

                      //  PageView.builder(
                      //   itemBuilder: (context, index) {

                      //     final project = snapshot.docs[index].data();

                      //     return BodyStack(project: project, user: user);
                      //   },
                      //   itemCount: snapshot.docs.length,
                      //   scrollDirection: Axis.vertical,
                      // );
                    }
                  },
                ),

                const SizedBox(
                  height: 45,
                ),
                // banner best experiences
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    width: size.width * 0.85,
                    height: 170,
                    decoration: const BoxDecoration(
                      color: Colord.thirdColor,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(31),
                        topEnd: Radius.circular(29),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "bestExperiences".tr(context),
                            style: txt524whiteText(),
                          ),
                        ),
                        Container(
                          width: size.width * 0.50,
                          child: SharedOutlineButton(
                            txt: "OrderService",
                            txtStyle: txt513whiteText(),
                            paddingHorizontal: 25,
                            borderColor: Colord.whit,
                            onPressed: () {
                              showModalBottomSheet(
                                  elevation: 15,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => BlocConsumer<
                                          MainHomeCubit, MainHomeState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          var c = MainHomeCubit.get(context);

                                          return Container(
                                            width: size.width,
                                            //height: size.height * .50,
                                            decoration: BoxDecoration(
                                              //color: Colord.main2,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                Text(
                                                  "Describe What is The Service You Need"
                                                      .tr(context),
                                                  style: txt520BlackTitle(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    minLines: 1,
                                                    maxLines: 7,
                                                    controller: controlle,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    c.sendNotifyToAssem(
                                                        orderMsg:
                                                            controlle.text,
                                                        collection: 'orders',
                                                        sender: user);
                                                    controlle.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        34))),
                                                    side: MaterialStateProperty
                                                        .all(
                                                      BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colord.blackOpacity,
                                                      ),
                                                    ),
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all(
                                                      more414blackText(),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 50.0,
                                                          vertical: 15),
                                                      child: DefaultTextStyle(
                                                        style:
                                                            txt418blackText(),
                                                        child: Text(
                                                          'Send'.tr(context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                //head of service provider
                SharedHeadMore(txtHead: "serviceProvider", onPressed: null
                    //  () {
                    //   navigateTo(
                    //       context,
                    //       ServiceProviderScreen(
                    //         user: user,
                    //       ));
                    // },
                    ),

                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 556,
                    child: FirestoreQueryBuilder<UserModel>(
                      query: cubit.queryForUser,
                      pageSize: 4,
                      builder: (context, snapshot, _) {
                        if (snapshot.isFetching) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            'Some Thing Wrong',
                            style: t4420BlackText(),
                          ));
                        } else if (snapshot.docs.isEmpty) {
                          return Container(
                            child:
                                const Text('There is No Service Provider yet'),
                          );
                        } else {
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: snapshot.docs.length,
                              itemBuilder: (context, index) {
                                final userData = snapshot.docs[index].data();
                                return SharedProviderItem(
                                    user: user, serviceProvider: userData);
                              });

                          // Container(
                          //   width: double.infinity,
                          //   height: 210,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: snapshot.docs.length,
                          //       itemBuilder: (context, index) {
                          //         final project = snapshot.docs[index].data();
                          //         return GestureDetector(
                          //           onTap: () {
                          //             navigateTo(
                          //                 context,
                          //                 ProjectDetailsScreen(
                          //                     project: project, user: user));
                          //           },
                          //           child: Padding(
                          //             padding:
                          //                 const EdgeInsets.symmetric(horizontal: 9.5),
                          //             child: Container(
                          //               width: 181,
                          //               height: 208,
                          //               clipBehavior: Clip.antiAliasWithSaveLayer,
                          //               decoration: BoxDecoration(
                          //                 color: Colord.bla,
                          //                 borderRadius: const BorderRadius.all(
                          //                   Radius.circular(11),
                          //                 ),
                          //                 image: DecorationImage(
                          //                   image: NetworkImage(
                          //                     project.imgUrls.split(',').first,
                          //                   ),
                          //                   opacity: 0.75,
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //               child: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.end,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       project.projectName,
                          //                       style: nameMeduim16white(),
                          //                     ),
                          //                     Text(
                          //                       "قيمة :${project.projectSumSales} ريال",
                          //                       style: txtMeduim13white(),
                          //                     ),
                          //                   ]),
                          //             ),
                          //           ),
                          //         );
                          //       }),
                          // );

                          //  PageView.builder(
                          //   itemBuilder: (context, index) {

                          //     final project = snapshot.docs[index].data();

                          //     return BodyStack(project: project, user: user);
                          //   },
                          //   itemCount: snapshot.docs.length,
                          //   scrollDirection: Axis.vertical,
                          // );
                        }
                      },
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Container(
                //     height: 556,
                //     child: GridView.builder(
                //         physics: const NeverScrollableScrollPhysics(),
                //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                //             maxCrossAxisExtent: 200,
                //             childAspectRatio: 0.7,
                //             crossAxisSpacing: 20,
                //             mainAxisSpacing: 20),
                //         itemCount: 4,
                //         itemBuilder: (context, index) => const SharedProviderItem()),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
