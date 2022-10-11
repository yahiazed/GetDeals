import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/shared_drawer.dart';
import '../../../../core/utiles/shared_widget/shared_dropdown.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/service_provider_cubit.dart';
import '../widgets/provider_Item.dart';
import 'service_provider_detail.dart';

class ServiceProviderScreen extends StatelessWidget {
  UserModel user;
  ServiceProviderScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var controller = TextEditingController();
    // final query = FirebaseFirestore.instance
    //     .collection('users')
    //     .where('userKind', isEqualTo: 1)
    //     .where('specialist', isEqualTo: 'Account management')
    //     // .orderBy('projectDate', descending: true)
    //     .withConverter<UserModel>(
    //       fromFirestore: (snapshot, _) =>
    //           UserModel.fromJsonServiceProvider(snapshot.data()!),
    //       toFirestore: (user, _) => user.toJsonServiceProvider(),
    //     );

    return BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
      listener: (context, state) {
        if (state is ServiceProviderInitial) {
          ServiceProviderCubit.get(context).setQuery();
        }
      },
      builder: (context, state) {
        var cubit = ServiceProviderCubit.get(context);

        return Container(
          decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: SharedDrawer(user: user),
            appBar: AppBar(
              backgroundColor: Colord.mainColor,
              centerTitle: true,
              title: SharedTitle(
                txt: "serviceProviderTitle".tr(context),
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
                          r1: 25, r2: 24, r3: 22, img: user.photo!),
                      title: Text(
                        'أهلا. ${user.name} ',
                        style: txt520whiteTitle(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                const SizedBox(
                  height: 34,
                ),
                Container(
                  height: 46,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        child: SharedDropdown(
                          dropdownValue: cubit.experienceskind,
                          values: cubit.experienceskindList,
                          onChanged: (p0) {
                            cubit.experienceskind = p0!;
                            cubit.setQueryKind();
                            //cubit.setQueryRate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: SharedDropdown(
                          dropdownValue: cubit.specialist,
                          values: cubit.specialistList,
                          onChanged: (p0) {
                            cubit.specialist = p0!;
                            cubit.setQuerySpecialist();
                            //cubit.setQueryRate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        child: DropdownButtonFormField(
                          //alignment: Alignment.center,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'rate',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  color: Colord.blackOpacity, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  color: Colord.blackOpacity, width: 2),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          value: cubit.experiencesRate,
                          onChanged: (p0) {
                            cubit.experiencesRate = p0!;
                            cubit.setQueryRate();
                          },
                          items: cubit.experiencesRateList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: hint414blackOpacityText(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Container(
                      //   height: 50,
                      //   width: 200,
                      //   child: SharedDropdown(
                      //     dropdownValue:
                      //         cubit.specialist ?? cubit.experiencesRateList[0],
                      //     values: cubit.experiencesRateList,
                      //     onChanged: (p0) {
                      //       cubit.experiencesRate = p0;
                      //       cubit.setQueryRate();
                      //     },
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                FirestoreQueryBuilder<UserModel>(
                    pageSize: 15,
                    query: cubit.query!,
                    builder: (context, snapshot, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 556,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 50),
                              itemCount: snapshot.docs.length,
                              itemBuilder: (context, index) {
                                final serviceProvider =
                                    snapshot.docs[index].data();
                                return SharedProviderItem(
                                  user: user,
                                  serviceProvider: serviceProvider,
                                );
                              }),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  // buildServiceProviderItem(BuildContext context, UserModel provider) {
  //   return InkWell(
  //     onTap: () => navigateTo(context, const ServiceDetailScreen()),
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 10.0),
  //       child: Container(
  //         width: 181,
  //         height: 208,
  //         clipBehavior: Clip.antiAliasWithSaveLayer,
  //         decoration: BoxDecoration(
  //           color: Colord.bla,
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(11),
  //           ),
  //           image: DecorationImage(
  //             image: NetworkImage(
  //               provider.photo!,
  //             ),
  //             opacity: 0.75,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 provider.name,
  //                 style: nameMeduim16white(),
  //               ),
  //               Row(
  //                 children: [
  //                   Text(
  //                     provider.specialist!,
  //                     style: txtMeduim13white(),
  //                   ),
  //                   const Spacer(),
  //                   Text(
  //                     "50 ريال بالساعه",
  //                     style: txtMeduim13white(),
  //                   ),
  //                 ],
  //               ),
  //             ]),
  //       ),
  //     ),
  //   );
  // }
}
